n= int(input("Enter a number: "))

l=[n*i for i in range(1,11)]

with open("table.txt", "a") as f:
    f.write(str(l)+"\n")