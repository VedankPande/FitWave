import "./App.css";

import Posture_webcam from "./posture_webcam";
import React, { useRef } from "react";
import "@tensorflow/tfjs-backend-webgl";
function App() {
  const webcamRef = useRef(null);
  const canvasRef = useRef(null);
  return (
    <div>
      <h3>FitWave</h3>
      <Posture_webcam />
    </div>
  );
}

export default App;
