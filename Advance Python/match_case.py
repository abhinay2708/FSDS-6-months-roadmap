def matching(status):
    match status:
        case 100:
            return "It's ok"
        
        case 200:
            return "It's also ok"
        
        case 300:
            return "It's little high"
        
        case 400:
            return "It's too high"
        
        case 500:
            return "It's critical"
        
print(matching(400))