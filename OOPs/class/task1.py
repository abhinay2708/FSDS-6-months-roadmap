class programmer:
    company="Microsoft"
    def __init__(self, name, age, salary):
        self.name=name
        self.age=age
        self.salary=salary

pro=programmer("Abhinay", 24, 50000)
print(pro.company,pro.name, pro.age, pro.salary)