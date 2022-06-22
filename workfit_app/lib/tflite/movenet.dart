import 'dart:math';
import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as image_lib;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';


class Movenet{

  Interpreter? _interpreter;

  final InterpreterOptions _interpreterOptions = InterpreterOptions()..useNnApiForAndroid =true;
  
  static const String modelName = 'lite-model_movenet_singlepose_lightning_tflite_float16_4.tflite';
  
  late List<int> _inputShape;
  late TfLiteType _inputType;
  late List<int> _outputShape;
  late TfLiteType _outputType;
  late TensorBuffer _outputBuffer;
  late TensorImage _inputImage;
  ImageProcessor? _imageProcessor = null;


  Movenet({Interpreter? interpreter}){
    loadModel(interpreter: interpreter);
  }
  
  // load the specified model and get input/output tensor information
  void loadModel({Interpreter? interpreter}) async {

    _interpreter =  interpreter ?? await Interpreter.fromAsset(modelName, options: _interpreterOptions);
    print("model successfully loaded");
    if (interpreter != null){
      var outputTensor = interpreter.getOutputTensor(0);
      var inputTensor = interpreter.getInputTensor(0);
      _inputShape = inputTensor.shape;
      _inputType = inputTensor.type;
      _outputShape = outputTensor.shape;
      _outputType = outputTensor.type;
      _outputBuffer = TensorBuffer.createFixedSize(_outputShape, _outputType);
    }
    
  }

  TensorBuffer predict(image_lib.Image image){
    print("start predicting");
    final initial = DateTime.now().millisecondsSinceEpoch;
    _inputImage = TensorImage(_inputType);
    _inputImage.loadImage(image);
    _inputImage = processImage();
    print("processed image info");
    print(_inputImage.dataType);
    print(_inputImage.buffer.asFloat32List());
    print(_inputImage.image);
    final post_process = DateTime.now().millisecondsSinceEpoch - initial;

    print('Time to load image: $post_process ms');

    
    try{
      final run_init = DateTime.now().millisecondsSinceEpoch;
      interpreter?.run(_inputImage.buffer, _outputBuffer.getBuffer());
      final run_post = DateTime.now().millisecondsSinceEpoch - run_init;

      print('Time to get predictions: $run_post ms');

      return _outputBuffer;
    }
    catch (err){
      print(err);
      return _outputBuffer;
    }

  }

  TensorImage processImage(){
    print("started processing");
    int cropSize = max(_inputImage.height,_inputImage.width);
    _imageProcessor ??= ImageProcessorBuilder()
      .add(ResizeWithCropOrPadOp(cropSize,cropSize))
      .add(ResizeOp(_inputShape[1],_inputShape[2],ResizeMethod.NEAREST_NEIGHBOUR))
      .add(NormalizeOp(127.5, 127.5))
      .build(); 
    return _imageProcessor!.process(_inputImage);
  }

  Interpreter? get interpreter => _interpreter;
}