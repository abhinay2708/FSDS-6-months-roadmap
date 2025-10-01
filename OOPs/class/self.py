class employee:
    age=24
    salary=120000
    name="Abhinay"
    
    def greet(self):
        print("Good Morning")
    
    def details(self):
        print(f"My name is {self.name}")
abhi=employee()
abhi.name="Abhi"
print(abhi.name,abhi.age)
abhi.greet()
abhi.details()