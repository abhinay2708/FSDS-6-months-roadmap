import cv2
import numpy as np
import streamlit as st

st.title("🎨 Color Detection on Uploaded Image")

# Sidebar for selecting color
color_option = st.sidebar.selectbox(
    "Choose a color to detect:",
    ["Red", "Green", "Blue", "Yellow", "Orange", "Purple"]
)

# Define HSV color ranges
color_ranges = {
    "Red": ([161, 155, 84], [179, 255, 255]),
    "Green": ([40, 100, 100], [102, 255, 255]),
    "Blue": ([94, 80, 2], [126, 255, 255]),
    "Yellow": ([20, 100, 100], [30, 255, 255]),
    "Orange": ([10, 100, 20], [25, 255, 255]),
    "Purple": ([129, 50, 70], [158, 255, 255])
}

# File uploader
uploaded_file = st.file_uploader("Upload an image", type=["jpg", "jpeg", "png"])

if uploaded_file is not None:
    # Read image as bytes → decode as cv2 image
    file_bytes = np.asarray(bytearray(uploaded_file.read()), dtype=np.uint8)
    image = cv2.imdecode(file_bytes, 1)

    # Convert to HSV
    hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)

    # Get selected color HSV range
    lower, upper = color_ranges[color_option]
    lower = np.array(lower)
    upper = np.array(upper)

    # Create mask
    mask = cv2.inRange(hsv_image, lower, upper)
    result = cv2.bitwise_and(image, image, mask=mask)

    # Convert BGR → RGB for Streamlit
    image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    result_rgb = cv2.cvtColor(result, cv2.COLOR_BGR2RGB)

    # Show original and result
    st.subheader("Original Image")
    st.image(image_rgb, channels="RGB")

    st.subheader(f"Detected Color: {color_option}")
    st.image(result_rgb, channels="RGB")
