import React, { useRef,useState } from 'react';
import { drawKeypoints,drawSkeleton } from './draw_utils';
import * as poseDetection from "@tensorflow-models/pose-detection";
import '@tensorflow/tfjs-backend-webgl';
import Webcam from "react-webcam";
import {Monitor} from "./monitoring";
import Dropdown from 'react-bootstrap/Dropdown';
import 'bootstrap/dist/css/bootstrap.min.css';
import $ from 'jquery';
//TODO: Move movenet code to separate file
export default function Posture_webcam(props){
  const [exercises,setExercise] = useState('Plank');
  var color = 'White';
  var exercise = "Plank";
  const webcamRef = useRef(null);
  const canvasRef = useRef(null);
  const detectorConfig = {modelType: poseDetection.movenet.modelType.SINGLEPOSE_THUNDER};
  const canvas = document.getElementById('output');
  const runMovenet = async () => {
    const movenet = await poseDetection.createDetector(poseDetection.SupportedModels.MoveNet,detectorConfig);
    setInterval(()=> {
      detect(movenet);
    },100)
  }

  $('#action1').on("click",function(){console.log("clicked action1");});

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
      console.log("pose points",pose);
      try {
        if(Monitor(exercises,pose[0]["keypoints"])){
          color = 'White'
        }
        else{
          color = 'Red'
        }
      } catch (error) {
        console.log("angle error:",error);
      }
      

      //TODO: Check posture and change color accordingly

      drawCanvas(pose[0],video,videoWidth,videoHeight,canvasRef,color);

    }

    
  };

  const drawCanvas = (pose,video,videoWidth,videoHeight,canvas,color) =>{
    const ctx = canvas.current.getContext("2d");
    canvas.current.width = videoWidth;
    canvas.current.height = videoHeight;

    drawKeypoints(pose["keypoints"],ctx,0.5,color);
    drawSkeleton(pose["keypoints"],ctx,0.5,color);
    


  }

  function test(){
    console.log("test complete");
    console.log(exercises);
  }

  runMovenet();

  return (
    <div className="App">
      <script></script>
      <Dropdown>
      <Dropdown.Toggle variant="success" id="dropdown-basic">
        Dropdown Button
      </Dropdown.Toggle>
    
      <Dropdown.Menu>
        <Dropdown.Item id = "action1" onClick = {setExercise('Biceps')}>Bicep Curls</Dropdown.Item>
        <Dropdown.Item id = "action2" onClick = {setExercise('Plank ')}>Plank</Dropdown.Item>
        <Dropdown.Item id = "action3" onClick = {setExercise('Press')}>Arm Press</Dropdown.Item>
      </Dropdown.Menu>
    </Dropdown>
      <header className="App-header">
      <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
      <script>
        {console.log("inside script")}
        {$('#action1').on("click",function(){console.log("clicked action1")})}
      </script>
        <Webcam
        audio = {false}
        ref = {webcamRef}
        style = {{
          position: "absolute",
          marginLeft: "auto",
          marginRight: "auto",
          left: 0,
          right: 0,
          textAlign: "center",
          zIndex: 9,
          width: 1280,
          height: 720,
        }}>
        </Webcam>

        <canvas
        ref = {canvasRef}
        style = {{
          position: "absolute",
          marginLeft: "auto",
          marginRight: "auto",
          left: 0,
          right: 0,
          textAlign: "center",
          zIndex: 9,
          width: 1280,
          height: 720,
        }}>

        </canvas>
      </header>
      
    </div>
  );
}

