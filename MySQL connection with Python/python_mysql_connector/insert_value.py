import mysql.connector

conn=mysql.connector.connect(host='localhost',user='root',password='Abhinay@123',database='pythondb')

mycursor=conn.cursor()

sql='insert into students (name,branch,id) values(%s,%s,%s)'

val=[('abhinay','fsds',38),('abhishek','da',23),('kuldeep','ds',28)]

mycursor.executemany(sql,val)

conn.commit()
print(mycursor.rowcount,'record inserted')