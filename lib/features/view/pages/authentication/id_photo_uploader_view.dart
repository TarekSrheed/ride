import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/core/helper/image_picker_helper.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_string.dart';
import 'package:ride_app/core/res/app_style.dart';
import 'package:ride_app/features/data/remote/upload_id.dart';
import 'package:ride_app/features/view/pages/map_page.dart';
import 'package:ride_app/features/view/provider/id_photo_provider.dart';
import 'package:ride_app/features/view/widget/button_widget.dart';

class IdPhotoUploaderScreen extends ConsumerWidget {
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  final UploadIdCard uploadIdCardToSupabase = UploadIdCard();
  IdPhotoUploaderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idPhoto = ref.watch(idPhotoProvider);
    final idPhotoNotifier = ref.read(idPhotoProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Id photo', style: titleStyle),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  _imagePickerHelper.showImageSourceSheet(
                      context, idPhotoNotifier);
                },
                child: Container(
                  margin:
                      EdgeInsets.only(top: 50, bottom: 15, left: 12, right: 15),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: primaryColor, width: 2),
                    color: Colors.white,
                  ),
                  child: idPhoto == null
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload,
                                    size: 60, color: primaryColor),
                                const SizedBox(height: 10),
                                const Text(
                                  'Tap to upload ID',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const Positioned(
                              bottom: 10,
                              child: Text('Accepted formats: JPG, PNG',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            idPhoto,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: 200,
                          ),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'We need your photo ID to activate your account and you will be able to rent a bike',
                  style: mustangStyle,
                ),
              ),
            ],
          ),
          if (idPhoto != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ButtonWidget(
                    title: 'Remove Photo',
                    ontap: () {
                      idPhotoNotifier.clearPhoto();
                    },
                    color: darkPrimaryColor.withOpacity(0),
                    textColor: blackColor,
                    borderColor: darkPrimaryColor,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  ButtonWidget(
                    title: AppString().SAVE,
                    ontap: () async {
                      final result =
                          await uploadIdCardToSupabase.uploadPhotoToSupabase(
                              context: context, idPhoto: idPhoto);
                      if (result == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapScreen(),
                          ),
                        );
                      }
                    },
                    color: darkPrimaryColor,
                    textColor: white,
                    borderColor: darkPrimaryColor,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
