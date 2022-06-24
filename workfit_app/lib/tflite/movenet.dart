import 'dart:math';
import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as image_lib;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class Movenet {
  Interpreter? _interpreter;

  final InterpreterOptions _interpreterOptions = InterpreterOptions()
    ..useNnApiForAndroid = true;
  static const String modelName =
      'lite-model_movenet_singlepose_lightning_3.tflite';

  late List<int> _inputShape;
  late TfLiteType _inputType;
  late List<int> _outputShape;
  late TfLiteType _outputType;
  late TensorBuffer _outputBuffer;
  late TensorImage _inputImage;
  ImageProcessor? _imageProcessor = null;
  late List<Object> inputs;
  TensorBuffer outputLocations = TensorBufferFloat([]);

  Movenet({Interpreter? interpreter}) {
    loadModel(interpreter: interpreter);
  }

  // load the specified model and get input/output tensor information
  void loadModel({Interpreter? interpreter}) async {
    _interpreter = interpreter ??
        await Interpreter.fromAsset(modelName, options: _interpreterOptions);
    print("model successfully loaded");
    if (interpreter != null) {
      var outputTensor = interpreter.getOutputTensor(0);
      var inputTensor = interpreter.getInputTensor(0);
      _inputShape = inputTensor.shape;
      _inputType = inputTensor.type;
      _outputShape = outputTensor.shape;
      _outputType = outputTensor.type;
      _outputBuffer = TensorBuffer.createFixedSize(_outputShape, _outputType);
      outputLocations = TensorBufferFloat([1,1,17,3]);
    }
  }

  dynamic predict(image_lib.Image image) {
    print("start predicting");
    final initial = DateTime.now().millisecondsSinceEpoch;
    _inputImage = TensorImage(_inputType);
    _inputImage.loadImage(image);
    _inputImage = processImage();
    inputs = [_inputImage.buffer];
    final post_process = DateTime.now().millisecondsSinceEpoch - initial;
    print('Time to load image: $post_process ms');

    try {
      final run_init = DateTime.now().millisecondsSinceEpoch;
      interpreter?.run(_inputImage.buffer, _outputBuffer.getBuffer());
      final run_post = DateTime.now().millisecondsSinceEpoch - run_init;

      print('Time to get predictions: $run_post ms');

      print("running test output for multiple");
      Map<int, Object> outputs = {0: outputLocations.buffer};
      interpreter?.runForMultipleInputs(inputs, outputs);

      print("getting parsed landmark data");
      List<dynamic> new_res = parseLandmarkData();
      print(new_res);
      printWrapped(new_res.toString());

      return new_res;
    } catch (err) {
      print(err);
      return [];
    }
  }
  
  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  parseLandmarkData() {
    List outputParsed = [];
    List<double> data = outputLocations.getDoubleList();
    List result = [];
    var x, y, c;

    for (var i = 0; i < 51; i += 3) {
      y = (data[0 + i] * 720).toInt();
      x = (data[1 + i] * 480).toInt();
      c = (data[2 + i]);
      result.add([x, y, c]);
    }
    outputParsed = result;

    // print("\n");
    // printWrapped(outputParsed.toString());
    // print("\n");

    return result;
  }

  TensorImage processImage() {
    print("started processing");
    int cropSize = max(_inputImage.height, _inputImage.width);
    _imageProcessor ??= ImageProcessorBuilder()
        .add(ResizeWithCropOrPadOp(cropSize, cropSize))
        .add(ResizeOp(_inputShape[1], _inputShape[2], ResizeMethod.BILINEAR))
        .build();
    _inputImage =  _imageProcessor!.process(_inputImage);
    return _inputImage;
  }

  Interpreter? get interpreter => _interpreter;
}
