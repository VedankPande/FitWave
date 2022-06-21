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

class _PostureWidgetState extends State<PostureWidget> with WidgetsBindingObserver{
  List<CameraDescription>? cameras;
  CameraController? controller;
  bool predicting = false;
  Movenet? _movenet;
  IsolateUtils? _isolateUtils;

  @override
  void initState() {
    super.initState();
    initStateMethod();
  }

  void initStateMethod() async{
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
      controller = new CameraController(
        cameras![1],
        ResolutionPreset.medium,
        enableAudio: false
      );
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

  cameraControllerCallback(CameraImage image) async{
    print("in camera callback");
    print(image.format.group);
    if (true){
      if (predicting){
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

      setState(() {
        predicting = false;
      });
    }
  }
  
  Future<String> inference(IsolateData isolateData) async{
    ReceivePort receivePort = ReceivePort();
   _isolateUtils?.sendPort?.send(isolateData..responsePort = receivePort.sendPort);
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
      if (controller != null){
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
    if(controller!=null){
      controller!.dispose();
    }
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller!.value.previewSize!;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(controller!),
    );
  }
}
