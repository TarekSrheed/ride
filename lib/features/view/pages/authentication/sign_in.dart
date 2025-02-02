// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_images.dart';
import 'package:ride_app/features/data/remote/auth_service.dart';
import 'package:ride_app/features/view/pages/authentication/sign_up.dart';
import 'package:ride_app/features/view/pages/navigation_pages.dart';
import 'package:ride_app/features/view/provider/immutable_data.dart';
import 'package:ride_app/features/view/widget/button_widget.dart';

import '../../../../core/res/app_string.dart';
import '../../../../core/res/app_style.dart';
import '../../widget/text_from_fild_widget.dart';

class SingInView extends StatefulWidget {
  const SingInView({super.key});

  @override
  State<SingInView> createState() => _SingInViewState();
}

class _SingInViewState extends State<SingInView> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final ValueNotifier<String?> _passwordError = ValueNotifier<String?>(null);
  final ValueNotifier<bool> _showPassword = ValueNotifier<bool>(false);

  void validatePassword(String value) {
    if (value.isEmpty) {
      _passwordError.value = 'Password cannot be empty';
    } else if (value.length < 8) {
      _passwordError.value = 'Password must be at least 8 characters';
    } else if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
      _passwordError.value = 'Password must include at least one letter';
    } else if (!RegExp(r'\d').hasMatch(value)) {
      _passwordError.value = 'Password must include at least one number';
    } else {
      _passwordError.value = null;
    }
  }

  Future<void> handleLogin() async {
    setState(() {
      showCircle = true;
    });
    final phone = phoneController.text.trim();
    final password = passwordController.text;




    final userData = await loginUser(phone, password);

    if (userData != null) {
      setState(() {
        showCircle = false;
      });
      await CheckUserStatus().getUserId(phone);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NavigationPage(),
        ),
      );
      print('Login Successful: ${userData['first_name']}');
    } else {
      setState(() {
        showCircle = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(color: Colors.red.shade700),
          ),
          content: const Text('Invalid phone number or password',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
          actions: [
            ButtonWidget1(
              titleSize: 17,
              height: 50,
              title: 'OK',
              ontap: () {
                Navigator.pop(context);
              },
              color: primaryColor,
              textColor: Colors.white,
              borderColor: primaryColor,
              width: 70,
            ),
          ],
        ),
      );
    }
  }

  bool showCircle = false;

  @override
  Widget build(BuildContext context) {
    double paddingWidth = MediaQuery.of(context).size.width;

    AppString appString = AppString();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            appString.BACK,
            style: appbarTitleStyle,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: (showCircle)
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: EdgeInsets.all(paddingWidth * 0.02),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 120),
                      child: Text(
                        appString.SIGNUINWITH,
                        style: titleStyle,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: ValueListenableBuilder<String?>(
                        valueListenable: _passwordError,
                        builder: (context, error, child) {
                          return ValueListenableBuilder<bool>(
                            valueListenable: _showPassword,
                            builder: (context, isPasswordVisible, child) {
                              return TextFromFildWidget(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  return null;
                                },
                                obscureText: !isPasswordVisible,
                                onChanged: validatePassword,
                                errorText: error,
                                readOnly: false,
                                controller: passwordController,
                                lableText: appString.ENTERYOURPASSWORD,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _showPassword.value = !_showPassword.value;
                                  },
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: subTilteTwoColor,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    ButtonWidget(
                      topHeight: 30,
                      title: appString.SIGNIN,
                      ontap: handleLogin,

                   

                      color: darkPrimaryColor,
                      textColor: white,
                      borderColor: primaryColor,
                      width: paddingWidth,
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: signUpWithStyle,
                        children: [
                          TextSpan(
                            text: appString.DONTHAVE,
                          ),
                          TextSpan(
                              text: appString.SIGINUP,
                              style: signInStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SingUpView(),
                                    ),
                                  );
                                })
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
