import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function(File) onSelectImage;

  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  Future<void> _selectImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    final imageFile = File(pickedImage.path);
    setState(() {
      _selectedImage = imageFile;
    });

    widget.onSelectImage(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _selectImage,
      icon: const Icon(Icons.camera),
      label: const Text("Select Image"),
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _selectImage,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 200,
      width: double.infinity,
      child: content,
    );
  }
}
