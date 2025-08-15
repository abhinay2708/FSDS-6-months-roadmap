import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

dataset=pd.read_csv(r"C:\Users\abhin\Downloads\emp_sal.csv")

x=dataset.iloc[:,1:2].values
y=dataset.iloc[:,2].values

from sklearn.linear_model import LinearRegression
lin_reg=LinearRegression()
lin_reg.fit(x,y)

plt.scatter(x,y,color='red')
plt.plot(x,lin_reg.predict(x),color='blue')
plt.title('Linear regression model (Linear Regression)')
plt.xlabel('Position Level')
plt.ylabel('Salary')
plt.show()

lin_model_pred=lin_reg.predict([[6]])
lin_model_pred

#Polynomial regression

from sklearn.preprocessing import PolynomialFeatures
poly_reg=PolynomialFeatures(degree=5)
x_poly=poly_reg.fit_transform(x)

poly_reg.fit(x_poly,y)

lin_reg_2=LinearRegression()
lin_reg_2.fit(x_poly,y)

plt.scatter(x,y,color='red')
plt.plot(x,lin_reg_2.predict(poly_reg.fit_transform(x)), color='blue')
plt.title('polymodel(polynomial regresssion)')
plt.xlabel('Position level')
plt.ylabel('Salary')
plt.show()

poly_model_pred=lin_reg_2.predict(poly_reg.fit_transform([[6]]))
poly_model_pred

#svr model
from sklearn.svm import SVR
svr_reg=SVR(kernel="rbf",degree=4)
svr_reg.fit(x,y)

svr_pred=svr_reg.predict([[6]])
print(svr_pred)

#KNN model
from sklearn.neighbors import KNeighborsRegressor
knn_reg=KNeighborsRegressor(n_neighbors=3)
knn_reg.fit(x,y)

knn_pred=knn_reg.predict([[6]])
print(knn_pred)

#Decision tree model 
from sklearn.tree import DecisionTreeRegressor
dt_reg=DecisionTreeRegressor()
dt_reg.fit(x,y)

dt_pred=dt_reg.predict([[6]])
print(dt_pred)

#Random Forest model
from sklearn.ensemble import RandomForestRegressor
rf_reg=RandomForestRegressor(random_state=0)
rf_reg.fit(x,y)

rf_pred=rf_reg.predict([[6]])
print(rf_pred)























