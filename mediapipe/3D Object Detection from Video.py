import cv2
import mediapipe as mp

mp_objectron = mp.solutions.objectron
mp_drawing = mp.solutions.drawing_utils

video_path = r"C:\Users\abhin\Downloads\shoe.mp4"
cap = cv2.VideoCapture(video_path)

objectron = mp_objectron.Objectron(
    static_image_mode=False,
    max_num_objects=5,
    min_detection_confidence=0.4,
    min_tracking_confidence=0.70,
    model_name='Shoe'
)

# Target display size (e.g., your monitor or a fixed window size)
DISPLAY_W, DISPLAY_H = 1280, 720   # change to your screen size if you want

def letterbox_resize(image, target_w, target_h):
    h, w = image.shape[:2]
    scale = min(target_w / w, target_h / h)
    new_w, new_h = int(w * scale), int(h * scale)
    resized = cv2.resize(image, (new_w, new_h))

    # Create black canvas and paste resized frame in center
    canvas = cv2.copyMakeBorder(
        resized,
        (target_h - new_h) // 2,
        (target_h - new_h + 1) // 2,
        (target_w - new_w) // 2,
        (target_w - new_w + 1) // 2,
        cv2.BORDER_CONSTANT,
        value=(0, 0, 0)
    )
    return canvas

cv2.namedWindow("Objectron", cv2.WINDOW_NORMAL)

while True:
    success, image = cap.read()
    if not success:
        cap.set(cv2.CAP_PROP_POS_FRAMES, 0)
        continue

    image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    results = objectron.process(image_rgb)
    image_bgr = cv2.cvtColor(image_rgb, cv2.COLOR_RGB2BGR)

    if results.detected_objects:
        for detected_object in results.detected_objects:
            mp_drawing.draw_landmarks(
                image_bgr,
                detected_object.landmarks_2d,
                mp_objectron.BOX_CONNECTIONS
            )
            mp_drawing.draw_axis(
                image_bgr,
                detected_object.rotation,
                detected_object.translation
            )

    # Scale to fit into window, no cropping
    display_frame = letterbox_resize(image_bgr, DISPLAY_W, DISPLAY_H)
    cv2.imshow("Objectron", display_frame)

    if cv2.waitKey(5) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
