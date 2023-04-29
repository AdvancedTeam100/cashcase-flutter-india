import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashfuse/controllers/networkController.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageControlller extends GetxController {
  NetworkController networkController = Get.find<NetworkController>();

  File imageFile;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<File> imageService(ImageSource imageSource) async {
    try {
      imageFile = new File('');
      final ImagePicker _picker = ImagePicker();
      XFile _selectedImage = await _picker.pickImage(source: imageSource);

      if (_selectedImage != null) {
        imageFile = File(_selectedImage.path);
        CroppedFile croppedFile = await ImageCropper().cropImage(
          sourcePath: _selectedImage.path,
          uiSettings: [
            AndroidUiSettings(
              initAspectRatio: CropAspectRatioPreset.square,
              hideBottomControls: true,
              backgroundColor: Colors.grey,
              toolbarColor: Colors.grey[100],
              toolbarWidgetColor: Colors.blue[200],
              activeControlsWidgetColor: Colors.blue[200],
              cropFrameColor: Colors.blue[200],
            ),
            WebUiSettings(context: Get.context)
          ],
        );

        if (croppedFile != null) {
          imageFile = File(croppedFile.path);
          update();
          return imageFile;
        }
      }
    } catch (e) {
      print("Exception - imageController.dart - imageService()" + e.toString());
    }
    return null;
  }
}
