# without walrus
# n = len(items)
# if n > 10:
#     print(n)

# with walrus
items=[13,12,44,23,54,24,55,33,66,3567,32,56]
if (n := len(items)) > 10:
    print(n)
