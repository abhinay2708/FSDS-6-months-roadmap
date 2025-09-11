import cv2
import numpy as np
import streamlit as st
from streamlit_webrtc import webrtc_streamer, VideoTransformerBase, RTCConfiguration

st.title("🎥 Real-time Color Detection with Webcam")

# Sidebar for selecting color
color_option = st.sidebar.selectbox(
    "Choose a color to detect:",
    ["All", "Red", "Green", "Blue", "Yellow", "Orange", "Purple"]
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

# BGR colors for drawing
color_bgr = {
    "Red": (0, 0, 255),
    "Green": (0, 255, 0),
    "Blue": (255, 0, 0),
    "Yellow": (0, 255, 255),
    "Orange": (0, 165, 255),
    "Purple": (255, 0, 255)
}

# Configure STUN + TURN servers
RTC_CONFIGURATION = RTCConfiguration(
    {
        "iceServers": [
            {"urls": ["stun:stun.l.google.com:19302"]},  # Free Google STUN
            {
                "urls": [
                    "turn:openrelay.metered.ca:80",
                    "turn:openrelay.metered.ca:443",
                    "turn:openrelay.metered.ca:443?transport=tcp",
                ],
                "username": "openrelayproject",
                "credential": "openrelayproject",
            },
        ]
    }
)


class ColorDetection(VideoTransformerBase):
    def transform(self, frame):
        img = frame.to_ndarray(format="bgr24")
        hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

        def detect_and_mark(color_name, lower, upper, img):
            lower = np.array(lower)
            upper = np.array(upper)
            mask = cv2.inRange(hsv, lower, upper)
            contours, _ = cv2.findContours(mask, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

            for cnt in contours:
                area = cv2.contourArea(cnt)
                if area > 800:  # filter small detections
                    x, y, w, h = cv2.boundingRect(cnt)
                    cv2.rectangle(img, (x, y), (x + w, y + h), color_bgr[color_name], 2)
                    cv2.putText(
                        img, color_name, (x, y - 10),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.8, color_bgr[color_name], 2
                    )
            return img

        if color_option == "All":
            for cname, (lower, upper) in color_ranges.items():
                img = detect_and_mark(cname, lower, upper, img)
        else:
            lower, upper = color_ranges[color_option]
            img = detect_and_mark(color_option, lower, upper, img)

        return img


# Start webcam stream
webrtc_streamer(
    key="color-detection",
    video_transformer_factory=ColorDetection,
    media_stream_constraints={"video": True, "audio": False},
    rtc_configuration=RTC_CONFIGURATION,
)
