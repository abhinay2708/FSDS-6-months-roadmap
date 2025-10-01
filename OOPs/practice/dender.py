class complex:
    def __init__(self,r,i):
        self.r=r
        self.i=i
        
    def __add__(self,a):
        return complex(self.r + a.r, self.i + a.i)
    
    def __str__(self):
        return f"{self.r} + {self.i}i"
    

c1=complex(1,2)
a=complex(3,4)
print(c1+a)