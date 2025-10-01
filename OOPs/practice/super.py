class grand:
    a=10
    def __init__(self):
        print("This is grand class")
    
class parent(grand):
    b=20
    def __init__(self):
        super().__init__()
        print("This is parent class")
    
class child(parent):
    c=30
    def __init__(self):
        super().__init__()
        print("This is child class")
    
x=child()
print(x.a, x.b, x.c)