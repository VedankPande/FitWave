import 'dart:developer';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class ImageSelector extends StatefulWidget {
  const ImageSelector({ Key? key }) : super(key: key);

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {

  bool loading = false;
  XFile? imageFile;
  List output = [];

  @override
  void initState(){
    super.initState();
    loadModel().then(
      (value){
        setState(() {});
      });
  }
  @override
  void dispose(){
    super.dispose();
    Tflite.close();
  }

  loadModel() async{
    await Tflite.loadModel(model: 'assets/lite-model_movenet_singlepose_lightning_tflite_int8_4.tflite',
    useGpuDelegate: false);
  }

  getPosePoints(io.File image) async {
    var output = await Tflite.runModelOnImage(path: image.path);
  }

  Future getImageFromGallery() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image==null) return;
    
    var model_output = await Tflite.runModelOnImage(
      path: image.path,
    );
    log(model_output![0]);
    setState(() {
      imageFile = image;
    });

    
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (imageFile==null)? const Text("No image selected") : Image.file(io.File(imageFile!.path)),
        FloatingActionButton(onPressed: getImageFromGallery)
      ],
    );
  }
}