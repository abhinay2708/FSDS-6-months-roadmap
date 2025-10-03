a=10

def fun():
    global a
    a= 15
    print(a)
    
fun()
print(a)