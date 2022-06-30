import "./App.css";
import "bootstrap/dist/css/bootstrap.min.css";
import Posture_webcam from "./posture_webcam";
import React, { useRef } from "react";
import "@tensorflow/tfjs-backend-webgl";
import {
  Navbar,
  Container,
  Nav,
  NavDropdown,
  Form,
  FormControl,
  Button,
} from "react-bootstrap";
function App() {
  const webcamRef = useRef(null);
  const canvasRef = useRef(null);
  return (
    <div>
      <Navbar bg="light" expand="lg">
        <Container fluid>
          <Navbar.Brand href="#" style={{ color: "purple" }}>
            <img
              alt=""
              src="./logo.png"
              width="30"
              height="30"
              className="d-inline-block align-top"
            />{" "}
            FitWave
          </Navbar.Brand>
          <Navbar.Toggle aria-controls="navbarScroll" />
          <Navbar.Collapse id="navbarScroll">
            <Nav
              className="me-auto my-2 my-lg-0"
              style={{ maxHeight: "100px" }}
              navbarScroll
            ></Nav>
            <Form className="d-flex">
              <Button
                variant="outline-success"
                style={{ color: "purple", borderColor: "purple" }}
              >
                Logout
              </Button>
            </Form>
          </Navbar.Collapse>
        </Container>
      </Navbar>
      <Posture_webcam />
    </div>
  );
}

export default App;
