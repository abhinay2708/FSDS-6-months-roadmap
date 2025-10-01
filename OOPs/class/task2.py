class calculator:
    def __init__(self, n):
        self.n=n
        
    def square(self):
        print(f"The square of the number is {self.n*self.n}")
    
    def cube(self):
        print(f"The cube of the number is {self.n**3}")
        
    def squareroot(self):
        print(f"The squareroot of the number is {self.n**0.5}")
        
cal=calculator(25)
cal.square()
cal.cube()
cal.squareroot()