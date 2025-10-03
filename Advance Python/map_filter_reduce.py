from functools import reduce
# map

l=[1,2,3,4,5,6,7,8,9,10]

sqr=map(lambda x : x*x, l)
print(list(sqr))


# filter 

def even(n):
    if n%2==0:
        return True
    return False

onlyeven=filter(even, l)
print(list(onlyeven))


# reduce
def sum(a,b):
    return a+b

print(reduce(sum, l))

