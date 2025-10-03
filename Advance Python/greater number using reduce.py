from functools import reduce

def greater(a,b):
    if a>b:
        return a
    return b

l=[12,34,55,65,30,67,80,25,67,85]

g=reduce(greater,l)
print(g)