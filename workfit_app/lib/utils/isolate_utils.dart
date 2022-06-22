import 'dart:isolate';
import 'dart:developer';
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as image_lib;
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:workfit_app/tflite/movenet.dart';
import 'package:workfit_app/utils/image_processing_utils.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';


class IsolateUtils{
  Isolate? _isolate;
  ReceivePort _receivePort = ReceivePort();
  SendPort? _sendPort;

  //getter to access private sendport from other classes
  SendPort? get sendPort => _sendPort;

  Future<void> start() async{
    print("starting isolate...");
    _isolate = await Isolate.spawn<SendPort>(
      entryPoint,
      _receivePort.sendPort 
    );
    print("isolate spawned");
    //receive sendport that entrypoint returns immediately
    _sendPort = await _receivePort.first;
  }
  static void entryPoint(SendPort sendport) async {
    log("running entrypoint");
    //new receive port inside spawned isolate to receive isolatedata (frames)
    final port = ReceivePort();
    log("created receive port");
    //send sendport of new receive port to class attribute (accessed from camera view using getter) 
    //to communicate with this isolate
    sendport.send(port.sendPort);
    log("sent sendport");

    //wait for data from main isolate
    await for (final IsolateData isolateData in port){
      log("in isolate loop");
      if (isolateData.responsePort!=null){

        Movenet movenet = Movenet(
          interpreter: Interpreter.fromAddress(isolateData.interpreterAdd)
        );
        image_lib.Image image = ImageUtils.convertCameraImage(isolateData.image!)!;
        if (io.Platform.isAndroid) {
          image = image_lib.copyRotate(image, 90);
        }
        log("running movenet in isolate");
        TensorBuffer results = movenet.predict(image);
        print("results:");
        print(results.buffer.asFloat32List());
        print(results.getDoubleList());
        //run movenet here - send results back to ui isolate via isolatedata response port
        isolateData.responsePort!.send("message received");
        
      }
    }
  }
}


class IsolateData{
  CameraImage? image;
  int interpreterAdd;
  SendPort? responsePort;

  IsolateData(
    this.image,
    this.interpreterAdd,
  );
}