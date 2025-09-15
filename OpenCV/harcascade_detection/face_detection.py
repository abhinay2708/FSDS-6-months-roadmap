import numpy as np
import cv2

face_classifier=cv2.CascadeClassifier(r"C:\Users\abhin\Downloads\haarcascade_frontalface_default.xml")

image=cv2.imread(r"C:\Users\abhin\OneDrive\Pictures\Camera Roll\WIN_20250902_16_43_49_Pro.jpg")

if image is None:
    print("Error")
    exit()
    
gray=cv2.cvtColor(image,cv2.COLOR_BGR2GRAY)

faces=face_classifier.detectMultiScale(gray,1.3,5)

if len(faces)==0:
    print("No face found")
else:
    for (x,y,w,h) in faces:
        cv2.rectangle(image, (x,y),(x+w,y+h), (127,0,255),2)
        
    cv2.imshow("Face Detection",image)
    cv2.waitKey(0)

cv2.destroyAllWindows()
