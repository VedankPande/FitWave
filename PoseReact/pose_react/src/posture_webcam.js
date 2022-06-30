import React, { useRef } from "react";
import { drawKeypoints, drawSkeleton } from "./draw_utils";
import * as poseDetection from "@tensorflow-models/pose-detection";
import "@tensorflow/tfjs-backend-webgl";
import Webcam from "react-webcam";
import { Monitor } from "./monitoring";

//TODO: Move movenet code to separate file
export default function Posture_webcam(props) {
  var color = "White";
  var exercise = "Press";
  const webcamRef = useRef(null);
  const canvasRef = useRef(null);
  const detectorConfig = {
    modelType: poseDetection.movenet.modelType.SINGLEPOSE_THUNDER,
  };
  const canvas = document.getElementById("output");
  const runMovenet = async () => {
    const movenet = await poseDetection.createDetector(
      poseDetection.SupportedModels.MoveNet,
      detectorConfig
    );
    setInterval(() => {
      detect(movenet);
    }, 100);
  };

  const detect = async (movenet) => {
    if (
      typeof webcamRef.current !== "undefined" &&
      webcamRef.current !== null &&
      webcamRef.current.video.readyState === 4
    ) {
      // Get Video Properties
      const video = webcamRef.current.video;
      const videoWidth = webcamRef.current.video.videoWidth;
      const videoHeight = webcamRef.current.video.videoHeight;

      // Set video width
      webcamRef.current.video.width = videoWidth;
      webcamRef.current.video.height = videoHeight;

      // Make Detections
      const pose = await movenet.estimatePoses(video);
      console.log("pose points", pose);
      try {
        if (Monitor(exercise, pose[0]["keypoints"])) {
          color = "White";
        } else {
          color = "Red";
        }
      } catch (error) {
        console.log("angle error:", error);
      }

      //TODO: Check posture and change color accordingly

      drawCanvas(pose[0], video, videoWidth, videoHeight, canvasRef, color);
    }
  };

  const drawCanvas = (pose, video, videoWidth, videoHeight, canvas, color) => {
    const ctx = canvas.current.getContext("2d");
    canvas.current.width = videoWidth;
    canvas.current.height = videoHeight;

    drawKeypoints(pose["keypoints"], ctx, 0.5, color);
    drawSkeleton(pose["keypoints"], ctx, 0.5, color);
  };

  runMovenet();

  // const drawCanvas = (pose, video, videoWidth, videoHeight, canvas) => {
  //   const ctx = canvas.current.getContext("2d");
  //   canvas.current.width = videoWidth;
  //   canvas.current.height = videoHeight;

  //   drawKeypoints(pose["keypoints"], 0.6, ctx);
  //   drawSkeleton(pose["keypoints"], 0.7, ctx);
  // };

  return (
    <div className="App">
      <header className="App-header">
        <Webcam
          audio={false}
          ref={webcamRef}
          style={{
            position: "absolute",
            marginLeft: "auto",
            marginRight: "auto",
            left: 0,
            right: 0,
            textAlign: "center",
            zIndex: 9,
            width: 1280,
            height: 720,
          }}
        ></Webcam>

        <canvas
          ref={canvasRef}
          style={{
            position: "absolute",
            marginLeft: "auto",
            marginRight: "auto",
            left: 0,
            right: 0,
            textAlign: "center",
            zIndex: 9,
            width: 1080,
            height: 720,
          }}
        ></canvas>
      </header>
    </div>
  );
}
