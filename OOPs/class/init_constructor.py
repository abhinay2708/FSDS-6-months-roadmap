class cons:
    name="Abhinay"
    age=24
    
    def __init__(self,name,language):
        # print("I am creating a constructor")
        self.name=name
        self.languge=language
    
    def hello(self):
        self.languge='Python'
        print(self.languge)
hi=cons("Abhi","Java")
print(hi.name,hi.languge)
# hi.hello()