import 'dart:math';
import 'dart:io' as io;

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';


class Movenet{

  Interpreter? _interpreter;

  final InterpreterOptions _interpreterOptions = InterpreterOptions()..useNnApiForAndroid =true;
  
  static const String modelName = 'lite-model_movenet_singlepose_lightning_tflite_int8_4.tflite';
  
  late List<int> _inputShape;
  late TfLiteType _inputType;
  late List<int> _outputShape;
  late TfLiteType _outputType;
  late TensorBuffer _outputBuffer;
  late TensorImage _inputImage;
  ImageProcessor? _imageProcessor = null;


  Movenet({Interpreter? interpreter}){
    loadModel();
  }
  
  // load the specified model and get input/output tensor information
  void loadModel({Interpreter? interpreter}) async {
    _interpreter =  interpreter ?? await Interpreter.fromAsset(modelName, options: _interpreterOptions);
    print("model successfully loaded");
    if (_interpreter != null){
      var outputTensor = _interpreter!.getOutputTensor(0);
      var inputTensor = _interpreter!.getInputTensor(0);
      _inputShape = inputTensor.shape;
      _inputType = inputTensor.type;
      _outputShape = outputTensor.shape;
      _outputType = outputTensor.type;
      _outputBuffer = TensorBuffer.createFixedSize(_outputShape, _outputType);
    }
    
  }

  TensorBuffer predict(io.File image){
    print("start predicting");
    final initial = DateTime.now().millisecondsSinceEpoch;
    _inputImage = TensorImage(_inputType);
    _inputImage = TensorImage.fromFile(image);
    _inputImage = processImage();
    final post_process = DateTime.now().millisecondsSinceEpoch - initial;

    print('Time to load image: $post_process ms');

    
    try{
      final run_init = DateTime.now().millisecondsSinceEpoch;
      _interpreter?.run(_inputImage.buffer, _outputBuffer.getBuffer());
      final run_post = DateTime.now().millisecondsSinceEpoch - run_init;

      print('Time to get predictions: $run_post ms');

      print(_outputBuffer.getDoubleList().shape);
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

  
}