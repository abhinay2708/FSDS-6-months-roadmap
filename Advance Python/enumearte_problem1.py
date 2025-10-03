# Write a program to print the 3rd, 5th, and 7th index value from a list using enumerate function.

l=[23,43,21,54,230,56,237,34,78]

for i, item in enumerate(l):
    if i==2 or i==4 or i==6:
        print(item)