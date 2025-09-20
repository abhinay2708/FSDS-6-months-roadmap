import mysql.connector 
conn = mysql.connector.connect(host='localhost',user='root',password='Abhinay@123',database='pythondb')

mycursor=conn.cursor()
mycursor.execute('create table students(name varchar(50),branch varchar(10),id int)')
mycursor.execute('show tables')

for x in mycursor:
    print(x)