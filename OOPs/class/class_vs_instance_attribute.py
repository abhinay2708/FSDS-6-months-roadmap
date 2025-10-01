class employe:
    age=24
    language="Python"
    
abhi=employe()
abhi.language="JavaScripts"   # Instance attributes are preffered first if not available then go to the class attribute
print(abhi.age,abhi.language)