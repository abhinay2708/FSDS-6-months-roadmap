from ultralytics import YOLO
import numpy

model=YOLO("yolo11n.pt")

detection_output=model.predict(source=r"C:\Users\abhin\Downloads\download (1).jpg",conf=0.25,save=True)

print(detection_output)

# print(detection_output[0].numpy())