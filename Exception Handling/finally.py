def hello():
    try:
        a=int(input("Enter a number"))
        return a
    
    except Exception as e:
        print(e)
        return
    
    finally:
        print("It's finally block")
        
hello()