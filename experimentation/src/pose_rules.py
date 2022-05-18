from turtle import left
import numpy as np

class PoseChecker():
    def __init__(self,landmarks) -> None:
        self.landmarks = landmarks

    def calculate_angle(self,a,b,c):
        a = np.array(a) 
        b = np.array(b) 
        c = np.array(c) 

        #get angle between lines (ab and bc) 
        radians = np.arctan2(c[1]-b[1], c[0]-b[0]) - np.arctan2(a[1]-b[1], a[0]-b[0])
        #convert from radians to degrees
        angle = np.abs(radians*180.0/np.pi)
        
        #only concerned with upper angle
        if angle >180.0:
            angle = 360-angle
        
        return angle
    
    def calculate_midpoint(self,a,b):
        a = np.array(a)
        b = np.array(b)

        return [(a[0]+b[0])/2,(a[1]+b[1])/2]

    #hip -23,24 shoulder 11,12 elbow 13,14, knee 25,26   # back straight - elbow tucked into hips 
    def bicep(self,keypoints):

        hip = [keypoints[self.landmarks.LEFT_HIP.value].x,keypoints[self.landmarks.LEFT_HIP.value].y]
        shoulder = [keypoints[self.landmarks.LEFT_SHOULDER.value].x,keypoints[self.landmarks.LEFT_SHOULDER.value].y]
        elbow = [keypoints[self.landmarks.LEFT_ELBOW.value].x,keypoints[self.landmarks.LEFT_ELBOW.value].y]
        knee = [keypoints[self.landmarks.LEFT_KNEE.value].x,keypoints[self.landmarks.LEFT_KNEE.value].y]
        elbow_angle = self.calculate_angle(hip,shoulder,elbow)
        back_angle = self.calculate_angle(shoulder,hip,knee)
        print("elbow: ",elbow_angle)
        if elbow_angle>15 or back_angle<170:
            return [[elbow_angle,elbow],[back_angle,hip]],False
        else:
            return [[elbow_angle,elbow],[back_angle,hip]],True
    
    #elbow shoulder hip TODO: Complete
    def shoulder_press(self,keypoints):

        elbow = [keypoints[self.landmarks.LEFT_ELBOW.value].x,keypoints[self.landmarks.LEFT_ELBOW.value].y]
        shoulder = [keypoints[self.landmarks.LEFT_SHOULDER.value].x,keypoints[self.landmarks.LEFT_SHOULDER.value].y]
        hip = [keypoints[self.landmarks.LEFT_HIP.value].x,keypoints[self.landmarks.LEFT_HIP.value].y]
        angle = self.calculate_angle(elbow,shoulder,hip)
        if angle>170 or angle < 150:
            return False
        else:
            return True
    
    def plank(self,keypoints):
        
        #get x,y values for joints
        left_eye = [keypoints[self.landmarks.LEFT_EYE.value].x,keypoints[self.landmarks.LEFT_EYE.value].y]
        right_eye = [keypoints[self.landmarks.RIGHT_EYE.value].x,keypoints[self.landmarks.RIGHT_EYE.value].y]
        left_shoulder = [keypoints[self.landmarks.LEFT_SHOULDER.value].x,keypoints[self.landmarks.LEFT_SHOULDER.value].y]
        right_shoulder = [keypoints[self.landmarks.RIGHT_SHOULDER.value].x,keypoints[self.landmarks.RIGHT_SHOULDER.value].y]
        left_hip = [keypoints[self.landmarks.LEFT_HIP.value].x,keypoints[self.landmarks.LEFT_HIP.value].y]
        right_hip = [keypoints[self.landmarks.RIGHT_HIP.value].x,keypoints[self.landmarks.RIGHT_HIP.value].y]
        left_knee = [keypoints[self.landmarks.LEFT_KNEE.value].x,keypoints[self.landmarks.LEFT_KNEE.value].y]
        right_knee = [keypoints[self.landmarks.RIGHT_KNEE.value].x,keypoints[self.landmarks.RIGHT_KNEE.value].y]

        #calculate middle points for pairs
        forehead = self.calculate_midpoint(left_eye,right_eye)
        upper_back = self.calculate_midpoint(left_shoulder,right_shoulder)
        waist = self.calculate_midpoint(left_hip,right_hip)
        middle_knee = self.calculate_midpoint(left_knee,right_knee)

        #calculate angles
        upper_angle = self.calculate_angle(forehead,upper_back,waist)
        lower_angle = self.calculate_angle(upper_back,waist,middle_knee)

        #return checker results and points for visualization
        if upper_angle < 150 or lower_angle<150:
            return [[upper_angle,forehead],[lower_angle,waist]],False
        else:
            return [[upper_angle,forehead],[lower_angle,waist]],True
        #print(self.calculate_angle(nose,upper_back,middle_waist))

