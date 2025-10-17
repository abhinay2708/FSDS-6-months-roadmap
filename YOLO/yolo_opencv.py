import random
import cv2
import numpy as np
from ultralytics import YOLO

my_file = open(r"C:\Users\abhin\FSDS\Deep_Learning\yolo\utils\coco.txt", "r")

data = my_file.read()
class_list = data.split("\n")
my_file.close()

detection_colors = []
for i in range(len(class_list)):
    r = random.randint(0, 255)
    g = random.randint(0, 255)
    b = random.randint(0, 255)
    detection_colors.append((b, g, r))
    
model = YOLO("weights/yolov8n.pt", "v8")

frame_wid = 640
frame_hyt = 480

cap = cv2.VideoCapture(r"C:\Users\abhin\Downloads\Wall.mp4")

if not cap.isOpened():
    print("Cannot open camera")
    exit()
    
while True:
    # Capture frame-by-frame
    ret, frame = cap.read()
    # if frame is read correctly ret is True

    if not ret:
        print("Can't receive frame (stream end?). Exiting ...")
        break

    #  resize the frame | small frame optimise the run
    # frame = cv2.resize(frame, (frame_wid, frame_hyt))

    # Predict on image
    detect_params = model.predict(source=[frame], conf=0.45, save=True)

    # Convert tensor array to numpy
    DP = detect_params[0].numpy()
    print(DP)

    if len(DP) != 0:
        for i in range(len(detect_params[0])):
            print(i)

            boxes = detect_params[0].boxes
            box = boxes[i]  # returns one box
            clsID = box.cls.numpy()[0]
            conf = box.conf.numpy()[0]
            bb = box.xyxy.numpy()[0]

            cv2.rectangle(
                frame,
                (int(bb[0]), int(bb[1])),
                (int(bb[2]), int(bb[3])),
                detection_colors[int(clsID)],
                3,
            )

            # Display class name and confidence
            font = cv2.FONT_HERSHEY_COMPLEX
            cv2.putText(
                frame,
                class_list[int(clsID)] + " " + str(round(conf, 3)) + "%",
                (int(bb[0]), int(bb[1]) - 10),
                font,
                1,
                (255, 255, 255),
                2,
            )

    # Get screen resolution (set manually to your monitor size)
    screen_w, screen_h = 1280, 720   # change this to your screen resolution

    # Get original frame size
    h, w = frame.shape[:2]

    # Scale factor to fit inside screen (preserve aspect ratio)
    scale = min(screen_w / w, screen_h / h)

    # New resized width & height
    new_w, new_h = int(w * scale), int(h * scale)

    # Resize frame
    frame = cv2.resize(frame, (new_w, new_h))

    
    # Display the resulting frame
    cv2.imshow("ObjectDetection", frame)

    # Terminate run when "Q" pressed
    if cv2.waitKey(1) == ord("q"):
        break

# When everything done, release the capture
cap.release()
cv2.destroyAllWindows()
    
