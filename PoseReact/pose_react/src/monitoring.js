import React from "react";

const KEYPOINT_DICT = {
    'nose': 0,
    'left_eye': 1,
    'right_eye': 2,
    'left_ear': 3,
    'right_ear': 4,
    'left_shoulder': 5,
    'right_shoulder': 6,
    'left_elbow': 7,
    'right_elbow': 8,
    'left_wrist': 9,
    'right_wrist': 10,
    'left_hip': 11,
    'right_hip': 12,
    'left_knee': 13,
    'right_knee': 14,
    'left_ankle': 15,
    'right_ankle': 16,
  };
export function Monitor(exercise,pose){
    const find_angle = (A,B,C) => {
        var AB = Math.sqrt(Math.pow(B.x-A.x,2)+ Math.pow(B.y-A.y,2));    
        var BC = Math.sqrt(Math.pow(B.x-C.x,2)+ Math.pow(B.y-C.y,2)); 
        var AC = Math.sqrt(Math.pow(C.x-A.x,2)+ Math.pow(C.y-A.y,2));
        var temp = Math.acos((BC*BC+AB*AB-AC*AC)/(2*BC*AB))
        if (temp>180){
            temp = temp-180
        }
        return (temp*180)/Math.PI;
    }
    const find_midpoint = (A,B) =>{
        return [(A.x-B.x)/2,(A.y-B.y)/2]
    }
  const check_bicep = () => {
    var hip ={"x":pose[KEYPOINT_DICT["left_hip"]].x,"y":pose[KEYPOINT_DICT["left_hip"]].y}
    var shoulder ={"x":pose[KEYPOINT_DICT["left_shoulder"]].x,"y":pose[KEYPOINT_DICT["left_shoulder"]].y}
    var elbow = {"x":pose[KEYPOINT_DICT["left_elbow"]].x, "y":pose[KEYPOINT_DICT["left_elbow"]].y}
    var knee ={"x":pose[KEYPOINT_DICT["left_knee"]].x,"y":pose[KEYPOINT_DICT["left_knee"]].y}
    console.log("elbow points",hip,shoulder,elbow)
    var elbow_angle = find_angle(hip,shoulder,elbow);
    var back_angle = find_angle(knee,hip,shoulder);
    console.log("elbow angle:",elbow_angle,"back_angle:",back_angle );
    if (elbow_angle>15 || back_angle<170){
            return false
    }
        else{
            return true
        }
  }
  const check_plank = () => {
    var left_eye ={"x":pose[KEYPOINT_DICT["left_eye"]].x,"y":pose[KEYPOINT_DICT["left_eye"]].y}
    var right_eye ={"x":pose[KEYPOINT_DICT["right_eye"]].x,"y":pose[KEYPOINT_DICT["right_eye"]].y}
    var left_shoulder ={"x":pose[KEYPOINT_DICT["left_shoulder"]].x,"y":pose[KEYPOINT_DICT["left_shoulder"]].y}
    var right_shoulder ={"x":pose[KEYPOINT_DICT["right_shoulder"]].x,"y":pose[KEYPOINT_DICT["right_shoulder"]].y}
    var left_hip ={"x":pose[KEYPOINT_DICT["left_hip"]].x,"y":pose[KEYPOINT_DICT["left_hip"]].y}
    var right_hip ={"x":pose[KEYPOINT_DICT["right_hip"]].x,"y":pose[KEYPOINT_DICT["right_hip"]].y}
    var left_knee ={"x":pose[KEYPOINT_DICT["left_hip"]].x,"y":pose[KEYPOINT_DICT["left_hip"]].y}
    var right_knee ={"x":pose[KEYPOINT_DICT["right_knee"]].x,"y":pose[KEYPOINT_DICT["right_knee"]].y}

    var forehead = find_midpoint(left_eye,right_eye)
    var upper_back = find_midpoint(left_shoulder,right_shoulder)
    var waist = find_midpoint(left_hip,right_hip)
    var middle_knee = find_midpoint(left_knee,right_knee)

    var upper_angle = find_angle(forehead,upper_back,waist)
    var lower_angle = find_angle(upper_back,waist,middle_knee)

    if (upper_angle<150 || lower_angle<150){
        return false
    }
    else{
        return true
    }

    
  }
  const check_shoulder_press = () => {
    var left_elbow = {"x":pose[KEYPOINT_DICT["left_elbow"]].x,"y":pose[KEYPOINT_DICT["left_elbow"]].y}
    var right_elbow = {"x":pose[KEYPOINT_DICT["right_elbow"]].x,"y":pose[KEYPOINT_DICT["right_elbow"]].y}
    var left_shoulder = {"x":pose[KEYPOINT_DICT["left_shoulder"]].x,"y":pose[KEYPOINT_DICT["left_shoulder"]].y}
    var right_shoulder = {"x":pose[KEYPOINT_DICT["right_shoulder"]].x,"y":pose[KEYPOINT_DICT["right_shoulder"]].y}
    var left_hip = {"x":pose[KEYPOINT_DICT["left_hip"]].x,"y":pose[KEYPOINT_DICT["left_hip"]].y}
    var right_hip = {"x":pose[KEYPOINT_DICT["right_hip"]].x,"y":pose[KEYPOINT_DICT["right_hip"]].y}

    var left_arm = find_angle(left_hip,left_shoulder,left_elbow)
    var right_arm = find_angle(right_hip,right_shoulder,right_elbow)

    if ((left_arm>170 || left_arm< 150) && (right_arm>170 || right_arm< 150)) {
        return false
    }
    else{
        return true
    }

  }

    switch(exercise){
        case "Biceps": return check_bicep();
        case "Plank": return check_plank();
        case "Pushup": return check_shoulder_press();
        default: return false;
    }


}
