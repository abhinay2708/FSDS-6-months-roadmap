l=[12,34,55,65,30,67,80,25,67,85]

def div(n):
    if n%5==0:
        return True
    return  False

new=filter(div,l)
print(list(new))