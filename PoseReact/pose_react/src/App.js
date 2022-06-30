import './App.css';

import Posture_webcam from './posture_webcam';
import React, { useRef } from 'react';
import '@tensorflow/tfjs-backend-webgl';
import 'bootstrap/dist/css/bootstrap.min.css';
function App() {
  const webcamRef = useRef(null);
  const canvasRef = useRef(null);
  return(
    <div>
      <Posture_webcam/>
    </div>
  );

}

export default App;
