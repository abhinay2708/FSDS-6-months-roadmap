#OBJECT DETECTION USING OPENCV

#I have 3 object with me 1> red 2> green 3> blue

'''How can we detect which color it is and how can way say to the computer only 1 specific color
that is what we are going to see using opencv'''

import cv2 # package of AI
import numpy as np

#Lets capture the camera. 0 for webcam. if you want other webcam then we can change to index to 1, 2
cap = cv2.VideoCapture(0)

#Lets load the frame
while True:
    _, frame = cap.read()
   
    #we convert this format to hsv , bgr library this is color format red, green, blue, we are frame with hsv which use to select the color

    hsv_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
    
    #Red
    low_red=np.array([161,155,84])
    high_red=np.array([179,255,255])
    red_mask=cv2.inRange(hsv_frame,low_red,high_red)
    red=cv2.bitwise_and(frame,frame,mask=red_mask)    
    
    #Green
    low_green=np.array([40,100,100])
    high_green=np.array([102,255,255])
    green_mask=cv2.inRange(hsv_frame,low_green,high_green)
    green=cv2.bitwise_and(frame,frame,mask=green_mask)    
    
    #Blue
    low_blue=np.array([94,80,2])
    high_blue=np.array([126,255,255])
    blue_mask=cv2.inRange(hsv_frame,low_blue,high_blue)
    blue=cv2.bitwise_and(frame,frame,mask=blue_mask)
    
    #Except White
    low=np.array([0,42,0])
    high=np.array([179,255,255])
    mask=cv2.inRange(hsv_frame,low,high)
    result=cv2.bitwise_and(frame,frame,mask=mask)    
   
# Lets frame on the windows  
    cv2.imshow("Frame", frame)
    cv2.imshow("red",red)
    cv2.imshow("blue",blue)
    cv2.imshow("green",green)
    cv2.imshow("result",result)
   
# weight key event which is 1 and which is 27 then break the loop that means we are going to stop the loop
    key = cv2.waitKey(1)
    if key == 27:
        break

# Lets run this one and we will see the camera, camera is on

# Now lets deeper understanding how to detect color now

''' HSV --> HUE - we can see the color red,green,blue,yellow and also we can see the gradiation of the color        
          SATURATION - How much quantity of the color we want to have
          (0- nothing, completely white, opencv - maximux pixel 0-255)
          VALUE - Brightness of the color (0- completely black)'''
#===========          
#Next step is to convert the color format to hsv