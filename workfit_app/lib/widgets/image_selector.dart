import 'dart:io' as io;
import 'dart:math';
import 'dart:ui';
import 'package:image/image.dart' as image_lib;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:workfit_app/tflite/movenet.dart';

class ImageSelector extends StatefulWidget {
  const ImageSelector({Key? key}) : super(key: key);

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {

  late Movenet _movenet;
  bool loading = false;
  XFile? imageFile;
  List output = [];

  @override
  void initState() {
    super.initState();
    _movenet = Movenet();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getImageFromGallery() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    print('image picked');
    if (image == null) return;
    print("getting predictions...");
    try{
      var movenet_output = _movenet.predict(io.File(image.path));
    }
    //Image.file(io.File(image.path))
    catch(e){
      print(e);
      var movenet_output = "error occured";
      print(movenet_output);
    }
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


