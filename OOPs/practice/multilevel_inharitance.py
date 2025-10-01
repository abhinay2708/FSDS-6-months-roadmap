class grand:
    a=10
    
class parent(grand):
    b=20
    
class child(parent):
    c=30
    
x=child()
print(x.a, x.b, x.c)