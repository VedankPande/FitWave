import 'dart:developer';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class ImageSelector extends StatefulWidget {
  const ImageSelector({Key? key}) : super(key: key);

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  bool loading = false;
  XFile? imageFile;
  List output = [];

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/lite-model_movenet_singlepose_lightning_tflite_int8_4.tflite',
        labels: 'assets/labels.txt',
        useGpuDelegate: false);
    print('model successfully loaded');
  }

  getPosePoints(io.File image) async {
    var output = await Tflite.runModelOnImage(path: image.path);
  }

  Future getImageFromGallery() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    print('image picked');
    if (image == null) return;

    print("image path:" + image.path);
    var model_output = await Tflite.runModelOnImage(
      path: io.File(image.path).path,
    );
    print("my_data");
    print(model_output);
    setState(() {
      imageFile = image;
    });
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (imageFile == null)
            ? const Text("No image selected")
            : Image.file(io.File(imageFile!.path)),
        FloatingActionButton(onPressed: getImageFromGallery)
      ],
    );
  }
}


class Movenet{
  Interpreter? _interpreter;

  final _interpreterOptions = InterpreterOptions()..useNnApiForAndroid =true;
  
  static const String modelName = 'lite-model_movenet_singlepose_lightning_tflite_int8_4.tflite';

  late List<int> _outputShape;
  late TfLiteType _outputType;
  late TensorBuffer _outputBuffer;

  Movenet({Interpreter? interpreter}){
    loadModel();
  }
  
  // load the specified model and get input/output tensor information
  void loadModel({Interpreter? interpreter}) async {
    _interpreter =  interpreter ?? await Interpreter.fromAsset(modelName, options: _interpreterOptions);

    if (_interpreter != null){
      var outputTensor = _interpreter!.getOutputTensor(0);
      _outputShape = outputTensor.shape;
      _outputType = outputTensor.type;
    }
    
  }

  //TODO: get output tensor shape and type from _intepreter - use that to create output buffer and run inference
  void predict(Image image){
    _outputShape = _interpreter!.getOutputTensor(0).shape;
    _outputType = _interpreter!.getOutputTensor(0).type;
    _outputBuffer = TensorBuffer.createFixedSize(_outputShape, _outputType);

  }

  // resize (with padding) and get tensor image 
  TensorImage processImage(TensorImage image){
    return image;
  }
}

