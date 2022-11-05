import 'dart:collection';
import 'dart:io';
import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/model/post_model.dart';
import 'package:coders_arena/services/api/api_services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path;
import 'package:coders_arena/services/firebase_services/firebase_storage_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreenController with ChangeNotifier {
  PostUploadingStatus postUploadingStatus = PostUploadingStatus.notUploading;
  final List<File> uploadImages = [];
  final ImagePicker _imagePicker = ImagePicker();
  final ApiServices _apiServices = ApiServices();

  List<String> captionKeywords = [
    'flutter',
    'programming',
    'coding',
    'technology',
    'cloud',
    'computing',
    'artificial',
    'intelligence',
    'machine',
    'learning',
    'go lang',
    'dart',
    'competitive',
    'programming',
    'contest',
    'google',
    'amazon',
    'facebook',
    'netflix',
    'c++',
    'c',
    'javascript',
    'react',
    'reactjs',
    'angular',
    'angularjs',
    'nodejs',
    'bootstrap',
    'android',
    'tailwindcss',
    'twitter',
    'github',
    'codeblocks',
    'django',
    'mongodb',
    'html',
    'css',
    'kotlin',
    'python',
    'java',
    'dotnet',
    'networking',
    'computer',
    'networks',
    'web',
    'development',
    'nodejs',
    'mongodb',
    'expressjs',
    'data',
    'science',
    'cyber',
    'security',
    'database',
    'c#',
    'perl',
    'ruby',
    'rust',
    'codechef',
    'codeforces',
    'leetcode',
    'atcoder',
    'visual',
    'basic',
    'fortran',
    'docker',
    'kubernetes',
    'git',
    'api',
  ];

  bool captionValidator(String caption) {
    int matchedWords = 0;
    caption = caption.toLowerCase();
    var captionKeywordsSet = HashSet<String>.from(captionKeywords);
    List<String> captionWords = caption.split(' ');
    int totalWords = captionWords.length;
    for (String word in captionWords) {
      if (word[word.length - 1] == ',' || word[word.length - 1] == '.') {
        word = word.substring(0, word.length - 1);
      }
      debugPrint(word);
      if (captionKeywordsSet.contains(word)) {
        matchedWords++;
      }
    }
    debugPrint((((matchedWords) / (totalWords)) * 100).toString());

    return totalWords>=15 ? ((matchedWords) / (totalWords)) * 100 >= 5 ? true : false : ((matchedWords) / (totalWords)) * 100 >= 10 ? true : false;
  }

  Future chooseImage() async {
    // debugPrint('called here');
    List<XFile>? pickedImage = await _imagePicker.pickMultiImage();
    for (var img in pickedImage) {
      final file = File(img.path);
      CroppedFile? croppedFile = await cropSquareImage(file);
      if (croppedFile != null) {
        debugPrint(croppedFile.path);
        File tempFile = File(croppedFile.path);
        uploadImages.add(tempFile);
      } else {
        continue;
      }
    }
    notifyListeners();
  }

  Future<CroppedFile?> cropSquareImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      compressQuality: 50,
      uiSettings: [
        androidUiSettingsLocked(),
      ],
    );
    return croppedFile;
  }

  AndroidUiSettings androidUiSettingsLocked() {
    return AndroidUiSettings(
      toolbarColor: Colors.indigo,
      toolbarWidgetColor: Colors.white,
    );
  }

  publishPost(String uid, String caption) async {
    postUploadingStatus = PostUploadingStatus.uploading;
    notifyListeners();
    try {
      List<String?> imageUrls = [];
      for (File img in uploadImages) {
        String? url = await getImageUrl(
            img, 'post/$uid/images/${path.basename(img.path)}');
        imageUrls.add(url);
      }
      uploadImages.clear();
      Post post = Post(
        uid: uid,
        caption: caption,
        imageUrls: imageUrls,
        likes: 0,
      );
      final Response? response = await _apiServices.post(
          apiEndUrl: 'posts/$uid.json', data: post.toJson());

      if (response != null) {
        final String postId = response.data['name'];
        await _apiServices.update(
            apiEndUrl: 'posts/$uid/$postId.json',
            data: {'postId': postId},
            message: "Post uploaded Successfully",
            showMessage: true);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    postUploadingStatus = PostUploadingStatus.notUploading;
    notifyListeners();
  }
}
