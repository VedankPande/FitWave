import 'dart:math' as math;

calculateAngle(a, b, c) {
  var radians = math.atan2(c[1] - b[1], c[0] - b[0]) -
      math.atan2(a[1] - b[1], a[0] - b[0]);
  var angle = (radians * 180.0 / math.pi).abs();

  if (angle > 180.0) {
    angle = 360 - angle;
  }

  return angle;
}

calculateMidpoint(a, b) {
  return [(a[0] + b[0]) / 2, (a[1] + b[1]) / 2];
}

bicep(keypoints) {
  var hip = [keypoints['left_hip'][0], keypoints['left_hip'][1]];
  var shoulder = [keypoints['left_shoulder'][0], keypoints['left_shoulder'][1]];
  var elbow = [keypoints['left_elbow'][0], keypoints['left_elbow'][1]];
  var knee = [keypoints['left_knee'][0], keypoints['left_knee'][1]];
  var elbow_angle = calculateAngle(hip, shoulder, elbow);
  var back_angle = calculateAngle(shoulder, hip, knee);
  if (elbow_angle > 15 || back_angle < 170) {
    return false;
  } else {
    return true;
  }
}

shoulder_press(keypoints) {
  var hip = [keypoints['left_hip'][0], keypoints['left_hip'][1]];
  var shoulder = [keypoints['left_shoulder'][0], keypoints['left_shoulder'][1]];
  var elbow = [keypoints['left_elbow'][0], keypoints['left_elbow'][1]];
  var angle = calculateAngle(elbow, shoulder, hip);
  if (angle > 170 || angle < 150) {
    return false;
  } else {
    return true;
  }
}

plank(keypoints) {
  var left_shoulder = [
    keypoints['left_shoulder'][0],
    keypoints['left_shoulder'][1]
  ];
  var right_shoulder = [
    keypoints['right_shoulder'][0],
    keypoints['right_shoulder'][1]
  ];
  var left_hip = [keypoints['left_hip'][0], keypoints['left_hip'][1]];
  var right_hip = [keypoints['right_hip'][0], keypoints['right_hip'][1]];
  var left_knee = [keypoints['left_knee'][0], keypoints['left_knee'][1]];
  var right_knee = [keypoints['right_knee'][0], keypoints['right_knee'][1]];
  var lower_angle_right = calculateAngle(right_shoulder, right_hip, right_knee);
  var lower_angle_left = calculateAngle(left_shoulder, left_hip, left_knee);
  if (lower_angle_right < 170 || lower_angle_left < 170) {
    return false;
  } else {
    return true;
  }
}
