class programmer:
    company="Microsoft"
    def comp(self):
        print(f"The company is {self.company}")
        
class employee:
    def emp(self):
        self.salary=30000
        print(f"The salary is {self.salary}")
        
class all(programmer, employee):
    print("All is here")
    
a= all()
a.comp()
a.emp()
        