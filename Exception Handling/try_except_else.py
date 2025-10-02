try:
    a=int(input("Enter a number"))
    print(a)
    
except Exception as e:
    print(e)
    
else:
    print("Try block executed")  # else block run when try block executed