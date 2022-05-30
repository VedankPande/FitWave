import mediapipe as mp
import cv2
import numpy as np
from pose_rules import PoseChecker

mp_drawing = mp.solutions.drawing_utils
mp_drawing_styles = mp.solutions.drawing_styles
mp_pose = mp.solutions.pose

COLOR_ERROR = (0,0,255)
COLOR_CORRECT = (0,255,0)
COLOR_DEFAULT = (255,255,255)

def video_capture():
    cap = cv2.VideoCapture(0)
    while cap.isOpened():
        ret, frame = cap.read()
        cv2.imshow('Mediapipe Feed', frame)
        
        if cv2.waitKey(10) & 0xFF == ord('q'):
            break
            
    cap.release()
    cv2.destroyAllWindows()

def run():
    pass

checker = PoseChecker(mp_pose.PoseLandmark)

cap = cv2.VideoCapture(0)
with mp_pose.Pose() as pose:
    while cap.isOpened:
        
        color = COLOR_DEFAULT
        ret,frame = cap.read()
        image = cv2.cvtColor(frame,cv2.COLOR_BGR2RGB)
        image.flags.writeable = False

        res = pose.process(image)
        my_img_1 = np.zeros((640, 480, 3), dtype = "uint8")
        
        try:
            landmarks = res.pose_landmarks.landmark

            visual_data,check = checker.plank(landmarks)
            
            #change color of visuals if incorrect pose
            if not check:
                color = COLOR_ERROR
            
            #print angles onto image
            for data in visual_data:
                cv2.putText(image, str(data[0]), 
                tuple(np.multiply(data[1], [640, 480]).astype(int)), 
                cv2.FONT_HERSHEY_SIMPLEX, 0.5, (17, 226, 245), 2, cv2.LINE_AA)
            
        except Exception as e:
            print("error",e)

        image.flags.writeable = True
        image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)


        #draw keypoints on image
        mp_drawing.draw_landmarks(image,res.pose_landmarks,mp_pose.POSE_CONNECTIONS,
                        mp_drawing.DrawingSpec(color = color, thickness =2,circle_radius=2),
                        mp_drawing.DrawingSpec(color = color,thickness =2,circle_radius=2))

        cv2.imshow('PoseTrainer', image)
        
        if cv2.waitKey(10) & 0xFF == ord('q'):
            break

