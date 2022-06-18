import 'dart:isolate';
import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:workfit_app/tflite/movenet.dart';


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
    //new receive port inside spawned isolate to receive isolatedata (frames)
    final port = ReceivePort();

    //send sendport of new receive port to class attribute (accessed from camera view using getter) 
    //to communicate with this isolate
    sendport.send(port.sendPort);

    //wait for data from main isolate
    await for (final IsolateData isolateData in port){
      log(isolateData.toString());
      if (isolateData.responsePort!=null){
        print("received isolate data: $isolateData");
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