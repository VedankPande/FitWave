import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:workfit_app/tflite/movenet.dart';


class IsolateUtils{
  Isolate? _isolate;
  ReceivePort _receivePort = ReceivePort();
  SendPort? _sendPort;

  SendPort? get sendPort => _sendPort;

  Future<void> start() async{
    _isolate = await Isolate.spawn<SendPort>(
      entryPoint,
      _receivePort.sendPort 
    );
    _sendPort = await _receivePort.first;
  }
  static void entryPoint(SendPort sendport) async {
    final port = ReceivePort();
    sendport.send(port.sendPort);

    await for (final IsolateData isolateData in port){
      if (isolateData.responsePort!=null){
        //run movenet here - send results back to ui isolate via isolatedata response port
        isolateData.responsePort!.send("message received");
        
      }
    }
  }
}


class IsolateData{
  CameraImage? image;
  int? interpreterAdd;
  SendPort? responsePort;

  IsolateData(
    this.image,
    this.interpreterAdd,
  );
}