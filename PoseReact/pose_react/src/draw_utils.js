import * as poseDetection from '@tensorflow-models/pose-detection';
import React from 'react';

class DrawingUtils extends React.Component{
  
}
export function drawKeypoints(keypoints,ctx,scoreThreshold,color) {
    const keypointInd =
        poseDetection.util.getKeypointIndexBySide(poseDetection.SupportedModels.MoveNet);
    ctx.fillStyle = color;
    ctx.strokeStyle = color;
    ctx.lineWidth = 2;

    for (const i of keypointInd.middle) {
    drawKeypoint(keypoints[i],ctx,scoreThreshold);
    }

    ctx.fillStyle = color;
    for (const i of keypointInd.left) {
    drawKeypoint(keypoints[i],ctx,scoreThreshold);
    }

    ctx.fillStyle = color;
    for (const i of keypointInd.right) {
    drawKeypoint(keypoints[i],ctx,scoreThreshold);
    }
}

export function drawKeypoint(keypoint,ctx,scoreThresholdParam) {
// If score is null, just show the keypoint.
const score = keypoint.score != null ? keypoint.score : 1;
const scoreThreshold = scoreThresholdParam || 0;

if (score >= scoreThreshold) {
  const circle = new Path2D();
  circle.arc(keypoint.x, keypoint.y, 4, 0, 2 * Math.PI);
  ctx.fill(circle);
  ctx.stroke(circle);
}
}

export function drawSkeleton(keypoints,ctx,scoreThresholdParam,color) {
ctx.fillStyle = color;
ctx.strokeStyle = color;
ctx.lineWidth = 2;

poseDetection.util.getAdjacentPairs(poseDetection.SupportedModels.MoveNet).forEach(([
                                                                  i, j
                                                                ]) => {
  const kp1 = keypoints[i];
  const kp2 = keypoints[j];

  // If score is null, just show the keypoint.
  const score1 = kp1.score != null ? kp1.score : 1;
  const score2 = kp2.score != null ? kp2.score : 1;
  const scoreThreshold = scoreThresholdParam || 0;

  if (score1 >= scoreThreshold && score2 >= scoreThreshold) {
    ctx.beginPath();
    ctx.moveTo(kp1.x, kp1.y);
    ctx.lineTo(kp2.x, kp2.y);
    ctx.stroke();
  }
});
}


