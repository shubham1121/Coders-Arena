import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

Future<String?> getImageUrl(File image, String location) async {
  try {
    final Reference storageReference =
    FirebaseStorage.instance.ref().child(location);
    final UploadTask uploadTask = storageReference.putFile(image);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final url = await taskSnapshot.ref.getDownloadURL();
    return url;
  } on FirebaseException catch (e) {
    debugPrint(e.message);
    return null;
  }
}
