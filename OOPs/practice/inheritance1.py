class vector2d:
    def __init__(self,i,j):
        self.i=i
        self.j=j
    
    def show(self):
        print(f"The 2d vector is {self.i}i + {self.j}j")
        
class vector3d(vector2d):
    def __init__(self,i,j,k):
        super().__init__(i,j)
        self.k=k
        
    def show(self):
        print(f"The 2d vector is {self.i}i + {self.j}j + {self.k}k")
        
        
obj=vector2d(2,3)
obj.show()
obj1=vector3d(1,5,4)
obj1.show()