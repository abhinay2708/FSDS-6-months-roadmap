class employee:
    salary=486876
    def sal(self):
        print(f"The salary is {self.salary}")
        
class office(employee):
    print("All is here")
    
a=office()
a.sal()