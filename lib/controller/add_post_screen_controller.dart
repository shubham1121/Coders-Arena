import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreenController with ChangeNotifier {
  final List<File> uploadImages = [];
  final ImagePicker _imagePicker = ImagePicker();

  Future chooseImage() async {
    List<XFile>? pickedImage = await _imagePicker.pickMultiImage();
    if (pickedImage == null) {
      return null;
    }
    for (var img in pickedImage) {
      final file = File(img.path);
      uploadImages.add(file);
    }
    notifyListeners();
  }
}
