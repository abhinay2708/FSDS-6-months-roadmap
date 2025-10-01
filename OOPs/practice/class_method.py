class abhi:
    a=10
    @classmethod
    def child(self):
        print(f"The class attribue is {self.a}")
        
x=abhi()
x.a=50
x.child()