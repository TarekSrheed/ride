import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/core/config/service_locator.dart';
import 'package:ride_app/core/helper/image_picker_helper.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_string.dart';
import 'package:ride_app/core/res/app_style.dart';
import 'package:ride_app/features/data/remote/auth_service.dart';
import 'package:ride_app/features/data/remote/upload_id.dart';
import 'package:ride_app/features/view/pages/authentication/welcome_view.dart';
import 'package:ride_app/features/view/provider/id_photo_provider.dart';

import 'package:ride_app/features/view/provider/personal_photo_provider.dart';
import 'package:ride_app/features/view/widget/active_widgets/show_dialog_widgets/show_dialog_widget.dart';
import 'package:ride_app/features/view/widget/button_widget.dart';
import 'package:ride_app/features/view/widget/container/show_snack_bar.dart';

import 'package:ride_app/features/view/widget/text_from_fild_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AppString appString = AppString();
  bool isOnlyRead = true;
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  final UploadPersonalPhoto uploadIdCardToSupabase = UploadPersonalPhoto();
  String? photoUrl = core.get<SharedPreferences>().getString('personalPhoto');
  int userId = core.get<SharedPreferences>().getInt('userId')!;
  bool showButtons = false;
  bool isphotoLoading = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  String? firstName;
  String? lastName;
  String? phone;
  @override
  void initState() {
    super.initState();
    _loadProfileData(); // استدعاء تحميل القيم المحدثة
  }

  Future<void> _updateProfile(String key, String value) async {
    final prefs = core.get<SharedPreferences>();
    await prefs.setString(key, value);
    await _loadProfileData(); // إعادة تحميل القيم المحدثة
  }

  Future<void> _updateProfile1(
      String key, String value, String key1, String value1) async {
    final prefs = core.get<SharedPreferences>();
    await prefs.setString(key, value);
    await prefs.setString(key1, value1);
    await _loadProfileData(); // إعادة تحميل القيم المحدثة
  }

  Future<void> _loadProfileData() async {
    final prefs = core.get<SharedPreferences>();
    setState(() {
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
      phone = prefs.getString('phone') ?? '';
    });

    // تحديث الـ Controllers بالقيم
    firstNameController.text = firstName!;
    lastNameController.text = lastName!;
    phoneController.text = phone!;
  }

  @override
  Widget build(BuildContext context) {
    // bool isOnlyRead = true;
    return Consumer(builder: (context, ref, _) {
      final idPhoto = ref.watch(personalPhotoProvider);
      final persoanlPhotoNotifier = ref.read(personalPhotoProvider.notifier);

      return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(
            AppString().PROFILE,
            style: titleStyle,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 0, bottom: 10, left: 12, right: 15),
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: proflileIconColor,
                    border: Border.all(color: primaryColor),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      (idPhoto == null && photoUrl == null)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 80,
                                  color: grayColor,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Tap to upload photo',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            )
                          : ClipOval(
                              child: (photoUrl == null)
                                  ? Image.file(
                                      height: double.infinity,
                                      idPhoto!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      height: double.infinity,
                                      photoUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(
                                          Icons.person,
                                          size: 80,
                                          color: grayColor,
                                        );
                                      },
                                      loadingBuilder:
                                          (context, child, progress) {
                                        if (progress == null) {
                                          return child;
                                        }

                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: primaryColor,
                                          ),
                                        );
                                      },
                                    ),
                            ),
                      Positioned(
                        top: 150,
                        right: 16,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              showButtons = true;
                            });
                            _imagePickerHelper.showImageSourceSheet1(
                                context, persoanlPhotoNotifier);
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              color: proflileIconColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              color: grayColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (showButtons)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ButtonWidget1(
                          titleSize: 14,
                          height: 30,
                          title: 'Cancel',
                          ontap: () {
                            setState(() {
                              showButtons = false;
                            });
                            persoanlPhotoNotifier.clearPhoto();
                          },
                          color: darkPrimaryColor.withOpacity(0),
                          textColor: blackColor,
                          borderColor: darkPrimaryColor,
                          width: MediaQuery.of(context).size.width * 0.3,
                        ),
                        ButtonWidget1(
                          height: 30,
                          titleSize: 14,
                          title: AppString().SAVE,
                          ontap: () async {
                            setState(() {
                              isphotoLoading = true;
                            });
                            final result = await uploadIdCardToSupabase
                                .uploadPersonalPhoto(
                                    context: context, idPhoto: idPhoto!);

                            setState(() {
                              isphotoLoading = false;
                            });
                            if (result == true) {
                              setState(() {
                                showButtons = false;
                              });
                            }
                          },
                          color: darkPrimaryColor,
                          textColor: white,
                          borderColor: darkPrimaryColor,
                          width: MediaQuery.of(context).size.width * 0.3,
                        ),
                      ],
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 15, top: 15),
                  child: TextFromFildWidget(
                    lableText: 'your name',
                    suffixIcon: InkWell(
                      onTap: () {
                        showProfileDialog(
                          context,
                          'Edit',
                          'Edit your name',
                          'First Name',
                          () async {
                            await CheckUserStatus().updateNameProfile(
                              userId: userId,
                              fistName: firstNameController.text,
                              lastName: lastNameController.text,
                            );
                            await _updateProfile1(
                                'lastName',
                                lastNameController.text,
                                'firstName',
                                firstNameController.text);
                          },
                          true,
                          firstNameController,
                        );
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    height: 50,
                    obscureText: false,
                    readOnly: true,
                    controller:
                        TextEditingController(text: "$firstName $lastName"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFromFildWidget(
                    suffixIcon: InkWell(
                      onTap: () {
                        showProfileDialog(
                          context,
                          'Edit',
                          'Edit your phone number',
                          'phone',
                          () async {
                            await CheckUserStatus().updatePhoneProfile(
                              userId: userId,
                              phone: phoneController.text,
                            );
                            await _updateProfile('phone', phoneController.text);
                          },
                          false,
                          phoneController,
                        );
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    height: 50,
                    obscureText: false,
                    textInputType: TextInputType.phone,
                    readOnly: true,
                    controller: TextEditingController(
                      text: phone,
                    ),
                    lableText: 'your phone',
                  ),
                ),
                // TextFromFildWidget(
                //   height: 50,
                //   obscureText: false,
                //   readOnly: false,
                //   controller: addressController,
                //   lableText: AppString().ADDRESS,
                // ),
                Consumer(builder: (context, ref, _) {
                  final idPhotoNotifier = ref.read(idPhotoProvider.notifier);
                  return ButtonWidget(
                      topHeight: MediaQuery.sizeOf(context).height / 6.5,
                      title: AppString().LOGOUT,
                      ontap: () {
                        idPhotoNotifier.clearPhoto();
                        core.get<SharedPreferences>().clear();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => WelcomView()),
                          (route) => false,
                        );
                      },
                      color: white,
                      textColor: primaryColor,
                      borderColor: primaryColor,
                      width: double.infinity);
                }),
                if (isphotoLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<dynamic> showProfileDialog(
    BuildContext context,
    String title,
    String subtitle,
    String labalText,
    Future<void> Function() ontap,
    bool show,
    TextEditingController controller,
  ) {
    bool isLoading = false; // متغير لحالة التحميل
    bool isSuccess = false; // متغير لحالة النجاح

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 25,
                ),
              ),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    (show)
                        ? TextFromFildWidget(
                            height: 45,
                            readOnly: false,
                            obscureText: false,
                            controller: controller,
                            lableText: labalText,
                          )
                        : TextFromFildWidget(
                            textInputType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a phone number';
                              } else if (!RegExp(r'^(?:\+?963|0)?9[0-9]{8}$')
                                  .hasMatch(value)) {
                                return 'Enter a valid phone number';
                              }
                              return null;
                            },
                            height: 45,
                            readOnly: false,
                            obscureText: false,
                            controller: controller,
                            lableText: labalText,
                          ),
                    if (show)
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: TextFromFildWidget(
                          height: 45,
                          readOnly: false,
                          obscureText: false,
                          controller: lastNameController,
                          lableText: "last name",
                        ),
                      ),
                    if (isLoading)
                      CircularProgressIndicator(color: primaryColor)
                    else if (isSuccess)
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 30),
                  ],
                ),
              ),
              actionsPadding:
                  const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonWidget1(
                      titleSize: 14,
                      height: 40,
                      title: 'cancel',
                      ontap: () {
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                      textColor: primaryColor,
                      borderColor: primaryColor,
                      width: 50,
                    ),
                    const SizedBox(width: 10),
                    ButtonWidget1(
                      titleSize: 14,
                      height: 40,
                      title: 'OK',
                      ontap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await ontap();
                            setState(() {
                              isLoading = false;
                              isSuccess = true;
                            });

                            Future.delayed(Duration(seconds: 1), () {
                              Navigator.pop(context);
                            });
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to update!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } else {
                          print('dddddddddd');
                        }
                      },
                      color: primaryColor,
                      textColor: Colors.white,
                      borderColor: primaryColor,
                      width: 50,
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
