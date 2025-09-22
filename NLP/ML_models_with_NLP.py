import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

dataset=pd.read_csv(r"C:\Users\abhin\Downloads\Restaurant_Reviews.tsv",delimiter='\t',quoting=3)

import re
import nltk
from nltk.corpus import stopwords
from nltk.stem.porter import PorterStemmer
 
corpus=[]
 
for i in range(0,1000):
    review=re.sub('[^a-zA-Z]',' ',dataset['Review'][i])
    review=review.lower()
    review=review.split()
    ps=PorterStemmer()
    review=[ps.stem(word) for word in review if not word in set(stopwords.words('english'))]
    review=' '.join(review)
    corpus.append(review)
'''    
from sklearn.feature_extraction.text import CountVectorizer
cv=CountVectorizer()    
 '''   
    
from sklearn.feature_extraction.text import TfidfVectorizer
cv=TfidfVectorizer()
x=cv.fit_transform(corpus).toarray()   
y=dataset.iloc[:,1].values

from sklearn.model_selection import train_test_split
x_train,x_test,y_train,y_test=train_test_split(x,y,test_size=0.30,random_state=0)
'''
from sklearn.tree import DecisionTreeClassifier  # ac=69 | ts=30/ac=71
classifier=DecisionTreeClassifier()
classifier.fit(x_train,y_train)
'''
from sklearn.linear_model import LogisticRegression  # ac= 76
classifier=LogisticRegression() 
classifier.fit(x_train,y_train)
'''
from sklearn.naive_bayes import MultinomialNB   # ac=77
classifier=MultinomialNB()
classifier.fit(x_train,y_train)

from sklearn.naive_bayes import GaussianNB  # ac=72
classifier=GaussianNB()
classifier.fit(x_train,y_train)

from sklearn.ensemble import RandomForestClassifier  # ac=73
classifier=RandomForestClassifier()
classifier.fit(x_train,y_train)

from sklearn.naive_bayes import BernoulliNB  # ac=77
classifier=BernoulliNB()
classifier.fit(x_train,y_train)

from sklearn.svm import SVC  # ac=76
classifier=SVC()
classifier.fit(x_train,y_train)

from sklearn.neighbors import KNeighborsClassifier  # ac=68
classifier=KNeighborsClassifier()
classifier.fit(x_train,y_train)


from sklearn.ensemble import GradientBoostingClassifier  # ac=72
classifier=GradientBoostingClassifier()
classifier.fit(x_train,y_train)

from xgboost import XGBClassifier  # ac=68
classifier=XGBClassifier()
classifier.fit(x_train,y_train)

from lightgbm import LGBMClassifier # ac=64
classifier=LGBMClassifier()
classifier.fit(x_train,y_train)

from catboost import CatBoostClassifier  # ac=73
classifier=CatBoostClassifier()
classifier.fit(x_train,y_train)
'''
y_pred=classifier.predict(x_test)

from sklearn.metrics import confusion_matrix
cm=confusion_matrix(y_test,y_pred)
print(cm)

bias=classifier.score(x_train,y_train)
variance=classifier.score(x_test,y_test)
print(f"bias={bias} variance={variance}")

from sklearn.metrics import classification_report
print(classification_report(y_test,y_pred))

# Apply all classification algorithm
# build model tfidf vectorizer
# 
