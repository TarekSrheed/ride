// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/features/data/remote/auth_service.dart';
import 'package:ride_app/features/view/pages/authentication/set_password_view.dart';
import 'package:ride_app/features/view/pages/authentication/sign_in.dart';
import 'package:ride_app/features/view/widget/button_widget.dart';
import 'package:ride_app/features/view/widget/container/show_snack_bar.dart';
import '../../../../core/res/app_string.dart';
import '../../../../core/res/app_style.dart';
import '../../widget/text_from_fild_widget.dart';

class SingUpView extends StatefulWidget {
  const SingUpView({super.key});

  @override
  State<SingUpView> createState() => _SingUpViewState();
}

class _SingUpViewState extends State<SingUpView> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isloading = false;
  Future<void> handleLogin() async {
    final phone = phoneController.text.trim();

    if (_formKey.currentState!.validate() && isChecked == true) {
      setState(() {
        isloading = true;
      });
      final exists = await CheckUserStatus().checkPhoneNumberExists(phone);

      if (exists) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Error',
              style: TextStyle(color: Colors.red.shade700),
            ),
            content: const Text('This phone num is used',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
        setState(() {
          isloading = false;
        });
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SetPasswordView(
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              phone: phoneController.text,
            ),
          ),
        );
        setState(() {
          isloading = false;
        });
      }
    } else if (isChecked == false) {
      showSnackbar(context, Colors.red, "please confirm the privacy policy");
    }
  }

  bool? isChecked = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double paddingWidth = MediaQuery.of(context).size.width;
    AppString appString = AppString();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(13),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  appString.SIGNUPWITH,
                  style: titleStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 15),
                  child: TextFromFildWidget(
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      } else if (!RegExp(r"^[\u0600-\u06FFa-zA-Z ]+$")
                          .hasMatch(value)) {
                        return 'Enter a valid name';
                      }
                      return null;
                    },
                    readOnly: false,
                    controller: firstNameController,
                    lableText: appString.FIRSTNAME,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFromFildWidget(
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      } else if (!RegExp(r"^[\u0600-\u06FFa-zA-Z ]+$")
                          .hasMatch(value)) {
                        return 'Enter a valid name';
                      }
                      return null;
                    },
                    readOnly: false,
                    controller: lastNameController,
                    lableText: appString.LASTNAME,
                  ),
                ),
                TextFromFildWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    } else if (!RegExp(r'^(?:\+?963|0)?9[0-9]{8}$')
                        .hasMatch(value)) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                  textInputType: TextInputType.number,
                  readOnly: false,
                  controller: phoneController,
                  lableText: appString.YOURMOBILE,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    appString.BYSIGININGUP,
                    style: bySiginingStyle,
                  ),
                  leading: Checkbox(
                    checkColor: darkPrimaryColor,
                    shape: const CircleBorder(),
                    side: BorderSide(
                      color: darkPrimaryColor,
                      width: 2,
                    ),
                    activeColor: Colors.white,
                    value: isChecked,
                    onChanged: (newbool) {
                      setState(() {
                        isChecked = newbool;
                      });
                    },
                  ),
                ),
                ButtonWidget(
                  topHeight: 40,
                  showCircle: isloading,
                  title: appString.SIGINUP,
                  ontap: handleLogin,
                  color: darkPrimaryColor,
                  textColor: white,
                  borderColor: primaryColor,
                  width: paddingWidth,
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    style: signUpWithStyle,
                    children: [
                      TextSpan(text: appString.ALREADYHAVE),
                      TextSpan(
                          text: appString.SIGNIN,
                          style: signInStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SingInView(),
                                ),
                              );
                            })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
