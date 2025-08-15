import numpy as np
import pandas as pd

dataset=pd.read_csv(r"C:\Users\abhin\Downloads\logit classification.csv")

x=dataset.iloc[:,[2,3]].values
y=dataset.iloc[:,-1].values

from sklearn.model_selection import train_test_split
x_train,x_test,y_train,y_test=train_test_split(x,y,test_size=0.20,random_state=0)

from sklearn.preprocessing import StandardScaler
sc=StandardScaler()
x_train=sc.fit_transform(x_train)
x_test=sc.transform(x_test)

'''
from sklearn.linear_model import LogisticRegression
classifier=LogisticRegression()
classifier.fit(x_train,y_train)
'''
'''
from sklearn.neighbors import KNeighborsClassifier
classifier=KNeighborsClassifier()
classifier.fit(x_train,y_train)
'''
'''
from sklearn.svm import SVC
classifier=SVC()
classifier.fit(x_train,y_train)
'''
'''
from sklearn.naive_bayes import BernoulliNB
classifier=BernoulliNB()
classifier.fit(x_train,y_train)
'''
'''
from sklearn.naive_bayes import GaussianNB
classifier=GaussianNB()
classifier.fit(x_train,y_train)
'''
'''
from sklearn.naive_bayes import MultinomialNB
classifier=MultinomialNB()
classifier.fit(x_train,y_train)
'''
'''
from sklearn.tree import DecisionTreeClassifier
classifier=DecisionTreeClassifier()
classifier.fit(x_train,y_train)
'''
from sklearn.ensemble import RandomForestClassifier
classifier=RandomForestClassifier()
classifier.fit(x_train,y_train)

y_pred=classifier.predict(x_test)

from sklearn.metrics import confusion_matrix
cm=confusion_matrix(y_pred,y_test)
print(cm)

from sklearn.metrics import accuracy_score
ac=accuracy_score(y_pred,y_test)
print(ac)

from sklearn.metrics import classification_report
cr=classification_report(y_pred,y_test)
print(cr)

bias=classifier.score(x_train,y_train)
print(bias)

variance=classifier.score(x_test,y_test)
print(variance)