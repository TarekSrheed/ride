import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';
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
          title: Text(
            appString.BACK,
            style: appBarBackStyle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(13),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
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
                  textInputType: TextInputType.phone,
                  readOnly: false,
                  controller: phoneController,
                  lableText: appString.YOURMOBILE,
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
                const SizedBox(height: 70),
                ButtonWidget(
                  title: appString.SIGINUP,
                  ontap: () {
                    if (_formKey.currentState!.validate() &&
                        isChecked == true) {
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
                    } else if (isChecked == false) {
                      showSnackbar(context, Colors.red,
                          "please confirm the privacy policy");
                    }
                  },
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
