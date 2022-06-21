import 'dart:isolate';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'package:workfit_app/tflite/movenet.dart';
import 'package:workfit_app/utils/isolate_utils.dart';
import 'dart:math' as math;

import 'package:workfit_app/widgets/image_selector.dart';

class PostureWidget extends StatefulWidget {
  const PostureWidget({Key? key}) : super(key: key);

  @override
  State<PostureWidget> createState() => _PostureWidgetState();
}

class _PostureWidgetState extends State<PostureWidget>
    with WidgetsBindingObserver {
  List<CameraDescription>? cameras;
  CameraController? controller;
  bool predicting = false;
  Movenet? _movenet;
  IsolateUtils? _isolateUtils;
  double randomInt = 0.1;
  int fps = 0;
  int currentTime = 0;
  int currentFrames = 0;

  @override
  void initState() {
    super.initState();
    initStateMethod();
  }

  void initStateMethod() async {
    WidgetsBinding.instance?.addObserver(this);

    //spawn new isolate
    _isolateUtils = IsolateUtils();
    await _isolateUtils?.start();

    // init camera
    print("intializing camera");
    _movenet = Movenet();
    getCamera();
  }

  getCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      cameras = await availableCameras();
      setState(() {
        cameras = cameras;
      });

      log('cameras from home' + cameras.toString());
      startProcess();
    } on CameraException catch (e) {
      log('Error: $e.code\nError Message: $e.message');
    }
  }

  startProcess() {
    if (cameras == null || cameras!.isEmpty) {
      log('No camera is found');
    } else {
      // ignore: unnecessary_new
      controller = new CameraController(cameras![1], ResolutionPreset.medium,
          enableAudio: false);
      controller?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        print("starting image stream");
        controller?.startImageStream(cameraControllerCallback);
      });
    }
  }

  cameraControllerCallback(CameraImage image) async {
    print("in camera callback");
    if (true) {
      if (predicting) {
        print("still predicting previous frame");
        return;
      }
      setState(() {
        predicting = true;
      });

      //create isolate data using current image
      var isolateData = IsolateData(image, _movenet!.interpreter!.address);
      print("isolate data in posturewidget $isolateData");
      //run inference in new isolate and return results
      print("waiting for inference...");
      String results = await inference(isolateData);

      log(results);

      final double temp = math.Random().nextDouble();
      log('random number generated $temp');

      setState(() {
        predicting = false;
        randomInt = temp;
      });
    }
  }

  Future<String> inference(IsolateData isolateData) async {
    ReceivePort receivePort = ReceivePort();
    _isolateUtils?.sendPort
        ?.send(isolateData..responsePort = receivePort.sendPort);
    var results = await receivePort.first;
    log("results in inference $results");
    return results;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        controller?.stopImageStream();
        break;
      case AppLifecycleState.resumed:
        if (controller != null) {
          if (!controller!.value.isStreamingImages) {
            await controller?.startImageStream(cameraControllerCallback);
          }
        }
        break;
      default:
    }
  }

  @override
  void dispose() {
    if (controller != null) {
      controller!.dispose();
    }
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  Widget funcitonRebuilt(screenSize) {
    log('random number received $randomInt');
    int newTime = ((new DateTime.now()).millisecondsSinceEpoch / 1000).round();
    if (currentTime != newTime) {
      fps = currentFrames;
      currentFrames = 0;
      currentTime = newTime;
    } else {
      currentFrames += 1;
    }

    return CustomPaint(
      size: screenSize,
      painter: MyPainter(
        modelData: [
          [0.49571934, 0.13109933, 0.49981618],
          [0.48342878, 0.11880877, 0.8029834],
          [0.4793319, 0.11880877, 0.75382113],
          [0.45065394, 0.14748675, 0.49981618],
          [0.45065394, 0.14748675, 0.70056206],
          [0.45884764, 0.22942382, 0.84395194],
          [0.44246024, 0.24990809, 0.84395194],
          [0.6022375, 0.27039236, 0.8808236],
          [0.5776564, 0.2949735, 0.6350124],
          [0.72514313, 0.29907033, 0.84395194],
          [0.70056206, 0.32774833, 0.8029834],
          [0.49981618, 0.4629445, 0.84395194],
          [0.49162248, 0.4711382, 0.75382113],
          [0.58175325, 0.6309155, 0.84395194],
          [0.5735596, 0.6350124, 0.8029834],
          [0.64320606, 0.82756454, 0.925889],
          [0.63910925, randomInt, 0.70056206],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }

    var screenSize = MediaQuery.of(context).size;
    var screenH = math.max(screenSize.height, screenSize.width);
    var screenW = math.min(screenSize.height, screenSize.width);
    var screenSizeTemp = controller!.value.previewSize!;
    var previewH = math.max(screenSizeTemp.height, screenSizeTemp.width);
    var previewW = math.min(screenSizeTemp.height, screenSizeTemp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;
    log('random number found $randomInt');
    return Stack(
      children: [
        OverflowBox(
          maxHeight: screenRatio > previewRatio
              ? screenH
              : screenW / previewW * previewH,
          maxWidth: screenRatio > previewRatio
              ? screenH / previewH * previewW
              : screenW,
          child: CameraPreview(controller!),
        ),
        funcitonRebuilt(screenSize),
        Text(
          'Rendering FPS: ${fps}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  //         <-- CustomPainter class
  final List modelData;
  MyPainter({required this.modelData});

  @override
  void paint(Canvas canvas, Size size) {
    log('random number received ${modelData[16][1]}');
    log('yes');
    final paintGreen = Paint()
      ..color = Colors.green
      ..strokeWidth = 3;
    final paintRed = Paint()
      ..color = Colors.red
      ..strokeWidth = 3;

    drawLine(p1, p2, {isPostureCorrect = true}) {
      log(p1.toString() + p2.toString());
      canvas.drawLine(
        p1 ?? const Offset(1, 1),
        p2 ?? const Offset(1, 1),
        isPostureCorrect ? paintGreen : paintRed,
      );
    }

    List listData = [];
    for (final data in modelData) {
      listData.add(
        Offset(
          data[1] * size.width,
          data[0] * size.height,
        ),
      );
    }

    final KEYPOINT_DICT = {
      'nose': listData[0],
      'left_eye': listData[1],
      'right_eye': listData[2],
      'left_ear': listData[3],
      'right_ear': listData[4],
      'left_shoulder': listData[5],
      'right_shoulder': listData[6],
      'left_elbow': listData[7],
      'right_elbow': listData[8],
      'left_wrist': listData[9],
      'right_wrist': listData[10],
      'left_hip': listData[11],
      'right_hip': listData[12],
      'left_knee': listData[13],
      'right_knee': listData[14],
      'left_ankle': listData[15],
      'right_ankle': listData[16],
    };

    // 'left_lower_leg':(13,15),
    drawLine(
      KEYPOINT_DICT['left_knee'],
      KEYPOINT_DICT['left_ankle'],
    );
    // 'right_lower_leg':(14,16),
    drawLine(
      KEYPOINT_DICT['right_knee'],
      KEYPOINT_DICT['right_ankle'],
    );
    // 'left_thigh':(11,13),
    drawLine(
      KEYPOINT_DICT['left_hip'],
      KEYPOINT_DICT['left_knee'],
    );
    // 'right_thigh':(12,14),
    drawLine(
      KEYPOINT_DICT['right_hip'],
      KEYPOINT_DICT['right_knee'],
    );
    // 'waist':(11,12),
    drawLine(
      KEYPOINT_DICT['right_hip'],
      KEYPOINT_DICT['right_knee'],
    );
    // 'left_abdomen':(5,11),
    drawLine(
      KEYPOINT_DICT['left_shoulder'],
      KEYPOINT_DICT['left_hip'],
    );
    // 'right abdomen':(6,12),
    drawLine(
      KEYPOINT_DICT['right_shoulder'],
      KEYPOINT_DICT['right_hip'],
    );
    // 'upper_abdomen':(5,6),
    drawLine(
      KEYPOINT_DICT['left_shoulder'],
      KEYPOINT_DICT['right_shoulder'],
    );
    // 'left_upper_arm':(5,7),
    drawLine(
      KEYPOINT_DICT['left_shoulder'],
      KEYPOINT_DICT['left_elbow'],
    );
    // 'right_upper_arm':(6,8),
    drawLine(
      KEYPOINT_DICT['right_shoulder'],
      KEYPOINT_DICT['right_elbow'],
    );
    // 'left_forearm':(7,9),
    drawLine(
      KEYPOINT_DICT['left_elbow'],
      KEYPOINT_DICT['left_wrist'],
    );
    // 'right_forearm':(8,10),
    drawLine(
      KEYPOINT_DICT['right_elbow'],
      KEYPOINT_DICT['right_wrist'],
    );
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
