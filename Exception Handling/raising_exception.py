a=int(input("Enter the first number"))
b=int(input("Enter the second number"))

if b==0:
    raise ZeroDivisionError("The number can't divide by zero")

else:
    print(a/b)