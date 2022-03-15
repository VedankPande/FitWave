import 'dart:ffi';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  const ImageSelector({ Key? key }) : super(key: key);

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {

  XFile? imageFile;

  Future getImageFromGallery() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image==null) return;
    
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