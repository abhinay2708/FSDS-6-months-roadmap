import pandas as pd
import re
import nltk
from nltk.corpus import stopwords
from nltk.stem.porter import PorterStemmer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, classification_report, confusion_matrix

# Load dataset
dataset = pd.read_csv(r"C:\Users\abhin\Downloads\Restaurant_Reviews.tsv", delimiter='\t', quoting=3)

# Preprocess text
corpus = []
ps = PorterStemmer()
for i in range(0, len(dataset)):
    review = re.sub('[^a-zA-Z]', ' ', dataset['Review'][i])
    review = review.lower().split()
    review = [ps.stem(word) for word in review if word not in set(stopwords.words('english'))]
    corpus.append(' '.join(review))

# Feature extraction using TF-IDF
tfidf = TfidfVectorizer(max_features=5000,ngram_range=(1,2))
x = tfidf.fit_transform(corpus).toarray()
y = dataset.iloc[:, 1].values

# Train-test split
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.20, random_state=0)

from imblearn.over_sampling import SMOTE
smote = SMOTE(random_state=0)
x_train_res, y_train_res = smote.fit_resample(x_train, y_train)


# Try multiple classifiers
from sklearn.linear_model import LogisticRegression
from sklearn.naive_bayes import MultinomialNB
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier

models = {
    "Logistic Regression": LogisticRegression(max_iter=1000),
    "Naive Bayes": MultinomialNB(),
    "SVM (Linear)": SVC(kernel="linear"),
    "Random Forest": RandomForestClassifier(n_estimators=200, random_state=0)
}

# Evaluate each model
results = []

for name, model in models.items():
    model.fit(x_train_res, y_train_res)
    y_pred = model.predict(x_test)

    acc = accuracy_score(y_test, y_pred)
    prec = precision_score(y_test, y_pred)
    rec = recall_score(y_test, y_pred)
    f1 = f1_score(y_test, y_pred)

    results.append([name, acc, prec, rec, f1])

    print("\n==============================")
    print(name)
    print("Confusion Matrix:\n", confusion_matrix(y_test, y_pred))
    print("Classification Report:\n", classification_report(y_test, y_pred))

# Show summary table
results_df = pd.DataFrame(results, columns=["Model", "Accuracy", "Precision", "Recall", "F1-Score"])
print("\n📊 Performance Comparison:\n")
print(results_df)
