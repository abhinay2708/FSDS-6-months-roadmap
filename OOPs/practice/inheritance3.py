class Employee:
    salary=200
    increment=20
    
    @property
    def salaryafterincrement(self):
        return (self.salary + (self.salary*self.increment)/100)
    
    @salaryafterincrement.setter
    def salaryafterincrement(self,salary):
        self.increment= ((salary/self.salary)-1)*100
        
e=Employee()
e.salaryafterincrement=250
print(e.increment)