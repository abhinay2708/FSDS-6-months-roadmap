import cv2
from ultralytics import solutions
import pyautogui  # to auto-detect screen resolution

# Load video
cap = cv2.VideoCapture("Pushups.demo.video.mp4")
assert cap.isOpened(), "Error reading video file"

# Get screen resolution
screen_w, screen_h = pyautogui.size()

# Get original video properties
orig_w, orig_h, fps = (int(cap.get(x)) for x in (cv2.CAP_PROP_FRAME_WIDTH,
                                                cv2.CAP_PROP_FRAME_HEIGHT,
                                                cv2.CAP_PROP_FPS))

# Scale factor (keep aspect ratio, no distortion)
scale = min(screen_w / orig_w, screen_h / orig_h)
new_w, new_h = int(orig_w * scale), int(orig_h * scale)

# Video writer (use resized resolution)
video_writer = cv2.VideoWriter(
    "Pushups.demo.video.output.mp4", 
    cv2.VideoWriter_fourcc(*"mp4v"), 
    fps, 
    (new_w, new_h)
)

# Init AIGym
gym = solutions.AIGym(
    show=True,  # Display the frame
    kpts=[5, 7, 9],  # keypoints index of person for monitoring pushup
    model="yolov8n-pose.pt",
    line_width=4,
    verbose=False
)

# Process video
while cap.isOpened():
    success, im0 = cap.read()
    if not success:
        print("Video frame is empty or processing completed.")
        break
    
    # Process with AIGym
    results = gym(im0)

    # Resize output to fit screen without distortion
    resized_frame = cv2.resize(results.plot_im, (new_w, new_h))

    # Save video
    video_writer.write(resized_frame)

# Release resources
cap.release()
video_writer.release()
