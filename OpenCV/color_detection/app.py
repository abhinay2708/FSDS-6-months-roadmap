import cv2
import numpy as np
import streamlit as st

st.title("🎨 Real-time Color Detection with OpenCV + Streamlit")

# Sidebar for selecting color
color_option = st.sidebar.selectbox(
    "Choose a color to detect:",
    ["Red", "Green", "Blue", "Yellow", "Orange", "Purple"]
)

# Checkbox created once (outside loop)
run_camera = st.sidebar.checkbox("Run Camera", value=True, key="run_camera")

# Define HSV color ranges
color_ranges = {
    "Red": ([161, 155, 84], [179, 255, 255]),
    "Green": ([40, 100, 100], [102, 255, 255]),
    "Blue": ([94, 80, 2], [126, 255, 255]),
    "Yellow": ([20, 100, 100], [30, 255, 255]),
    "Orange": ([10, 100, 20], [25, 255, 255]),
    "Purple": ([129, 50, 70], [158, 255, 255])
}

# Streamlit image placeholder
frame_window = st.image([])

# Capture webcam
cap = cv2.VideoCapture(0)

# Loop only if camera is running
while run_camera:
    ret, frame = cap.read()
    if not ret:
        st.error("Failed to access webcam.")
        break

    hsv_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

    # Get selected color HSV range
    lower, upper = color_ranges[color_option]
    lower = np.array(lower)
    upper = np.array(upper)

    mask = cv2.inRange(hsv_frame, lower, upper)
    result = cv2.bitwise_and(frame, frame, mask=mask)

    # Convert BGR → RGB for Streamlit
    result = cv2.cvtColor(result, cv2.COLOR_BGR2RGB)

    # Show frame
    frame_window.image(result)

cap.release()
