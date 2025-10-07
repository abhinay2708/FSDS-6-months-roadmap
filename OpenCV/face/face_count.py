# Import required libraries
import cv2

# Connect to your computer's default camera
cap = cv2.VideoCapture(0)

# Load OpenCV's pre-trained Haar Cascade face detector
# (comes with OpenCV, no extra download needed)
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_frontalface_default.xml")

while True:
    # Capture frame-by-frame
    ret, frame = cap.read()
    frame = cv2.flip(frame, 1)

    # Convert to grayscale
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Detect faces
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

    # Iterator to count faces
    i = 0
    for (x, y, w, h) in faces:
        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)

        # Increment iterator for each face in faces
        i += 1

        # Display the box and faces
        cv2.putText(frame, 'face num ' + str(i), (x - 10, y - 10),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
        print(f"Face {i}: x={x}, y={y}, w={w}, h={h}")

    # Display the resulting frame
    cv2.imshow('frame', frame)

    # Quit with "q"
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the capture and destroy the windows
cap.release()
cv2.destroyAllWindows()
