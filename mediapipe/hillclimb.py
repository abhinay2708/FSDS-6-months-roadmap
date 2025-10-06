"""
hand_control_hillclimb.py

Hand-gesture controller for Hill Climb Racing (or any PC game).
Uses MediaPipe for hand detection and PyAutoGUI (or pydirectinput) for keyboard control.

Default gesture -> key mapping (customizable below):
 - Open palm (all fingers up)      -> ACCEL (default 'up')  [keyDown while gesture active]
 - Fist (no fingers up)           -> RELEASE ACCEL
 - Two fingers (index+middle)     -> BRAKE (default 'down') [keyDown while active]
 - Tilt left/right (hand angle)   -> LEFT/RIGHT (default 'left'/'right') [keyDown while tilted]

Controls:
 - 'c' : calibrate neutral orientation
 - 'q' : quit
"""

import cv2
import mediapipe as mp
import numpy as np
import time
import math
import argparse

# Choose between pyautogui or pydirectinput if needed.
USE_PYDIRECTINPUT = False

try:
    if USE_PYDIRECTINPUT:
        import pydirectinput as kbd
    else:
        import pyautogui as kbd
except Exception as e:
    print("Keyboard control library import failed:", e)
    print("Install pyautogui or pydirectinput. Exiting.")
    raise

# ----------------- Config -----------------
ACCEL_KEY = "up"       # acceleration key
BRAKE_KEY = "down"     # brake/reverse key
LEFT_KEY = "left"
RIGHT_KEY = "right"

# Gesture thresholds and smoothing
TILT_THRESHOLD_DEG = 12     # degrees tilt to start steering
STEER_HYSTERESIS = 4        # degrees hysteresis to avoid flapping
SMOOTHING_ALPHA = 0.6       # exponential smoothing for tilt angle
FPS_SMOOTH_ALPHA = 0.8

CAM_INDEX = 0               # webcam index
CAM_WIDTH = 640
CAM_HEIGHT = 480
# -------------------------------------------

mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils

# Helper - fingers up detection based on landmark positions
FINGER_TIPS = [4, 8, 12, 16, 20]  # thumb tip, index tip, middle tip, ring tip, pinky tip
FINGER_PIPS = [3, 6, 10, 14, 18]  # thumb ip/other finger PIP

def fingers_up(hand_landmarks, handedness_label="Right"):
    """
    Returns list of booleans [thumb, index, middle, ring, pinky] whether each finger is 'up'
    Simple approach:
     - For fingers except thumb: tip.y < pip.y => finger up (screen coords: smaller y is up)
     - For thumb: use x relative to thumb ip and wrist depending on handedness
    """
    lm = hand_landmarks.landmark
    res = [False]*5
    # Index, middle, ring, pinky
    for i in range(1,5):
        tip = lm[FINGER_TIPS[i]]
        pip = lm[FINGER_PIPS[i]]
        res[i] = tip.y < pip.y  # finger extended if tip is above pip in image coordinates

    # Thumb: compare tip.x to ip.x relative to hand direction
    # Use wrist and index MCP to determine general left/right
    wrist = lm[0]
    index_mcp = lm[5]
    thumb_tip = lm[FINGER_TIPS[0]]
    thumb_ip = lm[FINGER_PIPS[0]]

    # If hand is facing camera, decide by x-comparison
    if handedness_label == "Right":
        res[0] = thumb_tip.x < thumb_ip.x  # right hand: thumb points left in image when extended
    else:
        res[0] = thumb_tip.x > thumb_ip.x

    return res

def hand_angle_deg(hand_landmarks):
    """
    Estimate roll (tilt) of the hand in degrees.
    Approach: compute vector from wrist to middle_finger_mcp and get angle relative to vertical.
    Positive -> hand tilting right (user's perspective) depending on camera mirror.
    """
    lm = hand_landmarks.landmark
    wrist = np.array([lm[0].x, lm[0].y])
    mid_mcp = np.array([lm[9].x, lm[9].y])  # middle finger MCP (landmark 9)
    vec = mid_mcp - wrist
    angle_rad = math.atan2(vec[1], vec[0])  # angle in image coords
    angle_deg = math.degrees(angle_rad)
    # Convert to a more intuitive tilt: compute angle relative to vertical axis
    tilt = 90 - angle_deg
    # Return tilt (positive = tilt to right)
    return tilt

def press_key(key):
    try:
        kbd.keyDown(key)
    except Exception:
        try:
            kbd.keyDown(key)  # try again
        except:
            pass

def release_key(key):
    try:
        kbd.keyUp(key)
    except Exception:
        try:
            kbd.keyUp(key)
        except:
            pass

def safe_press_release(key, do_press):
    """Hold or release key depending on do_press boolean."""
    if do_press:
        press_key(key)
    else:
        release_key(key)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--camera", type=int, default=CAM_INDEX)
    parser.add_argument("--width", type=int, default=CAM_WIDTH)
    parser.add_argument("--height", type=int, default=CAM_HEIGHT)
    parser.add_argument("--use-pydirectinput", action="store_true")
    args = parser.parse_args()

    global USE_PYDIRECTINPUT
    if args.use_pydirectinput:
        USE_PYDIRECTINPUT = True
        import pydirectinput as kbd_local
        globals()['kbd'] = kbd_local

    cap = cv2.VideoCapture(args.camera, cv2.CAP_DSHOW if hasattr(cv2, 'CAP_DSHOW') else 0)
    cap.set(cv2.CAP_PROP_FRAME_WIDTH, args.width)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, args.height)

    hands = mp_hands.Hands(
        max_num_hands=1,
        min_detection_confidence=0.7,
        min_tracking_confidence=0.6
    )

    accel_active = False
    brake_active = False
    left_active = False
    right_active = False

    smoothed_tilt = 0.0
    neutral_tilt_offset = 0.0
    last_time = time.time()
    fps = 0.0
    smoothed_fps = 0.0

    print("Starting webcam. Press 'c' to calibrate neutral orientation. Press 'q' to quit.")

    while True:
        ret, frame = cap.read()
        if not ret:
            print("Failed to grab frame. Exiting.")
            break

        frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        results = hands.process(frame_rgb)

        current_time = time.time()
        dt = current_time - last_time
        last_time = current_time
        if dt > 0:
            fps = 1.0 / dt
            smoothed_fps = FPS_SMOOTH_ALPHA * smoothed_fps + (1 - FPS_SMOOTH_ALPHA) * fps

        gesture_text = "No hand"

        if results.multi_hand_landmarks and len(results.multi_hand_landmarks) > 0:
            hand_landmarks = results.multi_hand_landmarks[0]
            handedness = "Right"
            if results.multi_handedness and len(results.multi_handedness) > 0:
                handedness = results.multi_handedness[0].classification[0].label

            mp_drawing.draw_landmarks(frame, hand_landmarks, mp_hands.HAND_CONNECTIONS)

            # Fingers up
            ups = fingers_up(hand_landmarks, handedness)
            # Count extended fingers except thumb for some gestures
            count_extended = sum(1 for x in ups if x)

            # Compute tilt
            tilt = hand_angle_deg(hand_landmarks) - neutral_tilt_offset
            # Smooth tilt
            smoothed_tilt = SMOOTHING_ALPHA * smoothed_tilt + (1 - SMOOTHING_ALPHA) * tilt

            # Gestures
            # Fist -> all false
            is_fist = (count_extended == 0)
            is_open_palm = (count_extended >= 4)  # 4 or 5 fingers
            is_two_fingers = (ups[1] and ups[2] and not ups[3] and not ups[4])  # index+middle only

            # Decide steering
            steer_left = False
            steer_right = False
            # Hysteresis: use different thresholds to start/stop steering
            if smoothed_tilt > TILT_THRESHOLD_DEG + STEER_HYSTERESIS:
                steer_right = True
            elif smoothed_tilt < -TILT_THRESHOLD_DEG - STEER_HYSTERESIS:
                steer_left = True
            else:
                # inside deadband -> no steering
                steer_left = steer_right = False

            # Apply gestures to key actions
            # ACCEL
            if is_open_palm:
                gesture_text = "Open palm -> ACCEL"
                if not accel_active:
                    press_key(ACCEL_KEY)
                    accel_active = True
            else:
                if accel_active:
                    release_key(ACCEL_KEY)
                    accel_active = False

            # BRAKE
            if is_two_fingers:
                if not brake_active:
                    press_key(BRAKE_KEY)
                    brake_active = True
                gesture_text = "Two fingers -> BRAKE"
            else:
                if brake_active:
                    release_key(BRAKE_KEY)
                    brake_active = False

            # Steering keys (left/right). If both false, release both.
            if steer_left:
                if not left_active:
                    press_key(LEFT_KEY)
                    left_active = True
                # ensure right releases
                if right_active:
                    release_key(RIGHT_KEY)
                    right_active = False
                gesture_text = "Steer LEFT"
            elif steer_right:
                if not right_active:
                    press_key(RIGHT_KEY)
                    right_active = True
                if left_active:
                    release_key(LEFT_KEY)
                    left_active = False
                gesture_text = "Steer RIGHT"
            else:
                if left_active:
                    release_key(LEFT_KEY)
                    left_active = False
                if right_active:
                    release_key(RIGHT_KEY)
                    right_active = False

            # Display debug info
            info = f"Tilt: {smoothed_tilt:.1f}  Fingers: {ups}  FPS: {smoothed_fps:.1f}"
            cv2.putText(frame, info, (10, 20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (20,255,20), 1)

        else:
            # No hand: release all keys for safety
            gesture_text = "No hand"
            if accel_active:
                release_key(ACCEL_KEY); accel_active = False
            if brake_active:
                release_key(BRAKE_KEY); brake_active = False
            if left_active:
                release_key(LEFT_KEY); left_active = False
            if right_active:
                release_key(RIGHT_KEY); right_active = False

        cv2.putText(frame, gesture_text, (10, frame.shape[0]-10), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0,200,255), 2)
        cv2.imshow("Hand Control - Hill Climb", frame)

        key = cv2.waitKey(1) & 0xFF
        if key == ord('q'):
            print("Quitting.")
            break
        elif key == ord('c'):  # calibrate neutral tilt
            print("Calibrating neutral tilt offset.")
            # If a hand is present, use current measured tilt to set neutral offset
            if results.multi_hand_landmarks and len(results.multi_hand_landmarks) > 0:
                measured = hand_angle_deg(results.multi_hand_landmarks[0])
                neutral_tilt_offset = measured
                smoothed_tilt = 0.0
                print(f"Neutral tilt offset set to {neutral_tilt_offset:.2f} degrees.")
            else:
                print("No hand detected; cannot calibrate.")

    # cleanup: release any keys held
    try:
        release_key(ACCEL_KEY)
        release_key(BRAKE_KEY)
        release_key(LEFT_KEY)
        release_key(RIGHT_KEY)
    except:
        pass

    cap.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    main()
