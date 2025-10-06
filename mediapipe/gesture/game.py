import cv2
import mediapipe as mp
import pyautogui

# Webcam
cap = cv2.VideoCapture(0)

# MediaPipe
mp_hands = mp.solutions.hands
hands = mp_hands.Hands(max_num_hands=1, min_detection_confidence=0.7)
mp_draw = mp.solutions.drawing_utils

tip_ids = [4, 8, 12, 16, 20]
prev_fingers = -1  # To avoid duplicate presses

while True:
    success, img = cap.read()
    img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    results = hands.process(img_rgb)

    if results.multi_hand_landmarks:
        for hand_landmarks in results.multi_hand_landmarks:
            lm_list = []
            for id, lm in enumerate(hand_landmarks.landmark):
                h, w, c = img.shape
                cx, cy = int(lm.x * w), int(lm.y * h)
                lm_list.append((id, cx, cy))

            # Count fingers
            fingers = []
            if lm_list[4][1] > lm_list[3][1]:
                fingers.append(1)
            else:
                fingers.append(0)

            for id in range(1, 5):
                if lm_list[tip_ids[id]][2] < lm_list[tip_ids[id] - 2][2]:
                    fingers.append(1)
                else:
                    fingers.append(0)

            total_fingers = fingers.count(1)

            # Display count
            cv2.putText(img, f'Fingers: {total_fingers}', (10, 70),
                        cv2.FONT_HERSHEY_SIMPLEX, 1.2, (255, 0, 0), 2)
            mp_draw.draw_landmarks(img, hand_landmarks, mp_hands.HAND_CONNECTIONS)

            # Trigger key presses
            if total_fingers != prev_fingers:
                prev_fingers = total_fingers

                if total_fingers == 1:
                    pyautogui.press('up')
                    print("Pressed: UP")
                elif total_fingers == 2:
                    pyautogui.press('down')
                    print("Pressed: DOWN")
                elif total_fingers == 3:
                    pyautogui.press('left')
                    print("Pressed: LEFT")
                elif total_fingers == 4:
                    pyautogui.press('right')
                    print("Pressed: RIGHT")
                elif total_fingers == 5:
                    pyautogui.press('space')
                    print("Pressed: SPACE")

    cv2.imshow("Gesture Controller", img)

    if cv2.waitKey(1) == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()