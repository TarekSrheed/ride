import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_app/features/view/provider/id_photo_provider.dart';

class ImagePickerHelper {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<File?> pickFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  void showImageSourceSheet(BuildContext context, IdPhotoNotifier notifier) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
              child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('take a photo'),
                onTap: () async {
                  Navigator.pop(context);
                  final photo = await pickFromCamera();
                  if (photo != null) {
                    notifier.updatePhoto(photo);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('choose From Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final photo = await pickFromGallery();
                  if (photo != null) {
                    notifier.updatePhoto(photo);
                  }
                },
              )
            ],
          ));
        });
  }
}
