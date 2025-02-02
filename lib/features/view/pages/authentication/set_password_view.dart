// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/core/config/service_locator.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_style.dart';
import 'package:ride_app/features/data/remote/auth_service.dart';
import 'package:ride_app/features/view/pages/authentication/id_photo_uploader_view.dart';
import 'package:ride_app/features/view/provider/immutable_data.dart';
import 'package:ride_app/features/view/widget/button_widget.dart';
import 'package:ride_app/features/view/widget/text_from_fild_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/res/app_string.dart';

class SetPasswordView extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phone;
  SetPasswordView({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  @override
  State<SetPasswordView> createState() => _SetPasswordViewState();
}

class _SetPasswordViewState extends State<SetPasswordView> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmeController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<String?> _passwordError = ValueNotifier<String?>(null);

  final ValueNotifier<bool> _showPassword = ValueNotifier<bool>(false);

  final ValueNotifier<DateTime?> _selectDate = ValueNotifier<DateTime?>(null);

  final ValueNotifier<bool> _showConfirmPassword = ValueNotifier<bool>(false);

  final ValueNotifier<bool> _showCircle = ValueNotifier<bool>(false);

  final AppString appString = AppString();

  bool isloading = false;

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

  Future<void> _setDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _selectDate.value = picked;
      dateController.text = "${picked.year}-${picked.month}-${picked.day}";
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appString.SETYOURPASSWORD,
                style: titleStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ValueListenableBuilder(
                    valueListenable: _selectDate,
                    builder: (context, selectedDate, child) {
                      return TextFromFildWidget(
                        obscureText: false,
                        readOnly: true,
                        prefixIcon: const Icon(Icons.calendar_today),
                        controller: dateController,
                        onTap: () {
                          _setDate(context);
                        },
                        lableText: appString.DATE,
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 15),
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
              ValueListenableBuilder(
                  valueListenable: _showConfirmPassword,
                  builder: (context, isPasswordVisible, child) {
                    return TextFromFildWidget(
                      obscureText: !isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm password';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      readOnly: false,
                      controller: confirmeController,
                      lableText: appString.CONFIRMPASSWORD,
                      suffixIcon: IconButton(
                        onPressed: () {
                          _showConfirmPassword.value =
                              !_showConfirmPassword.value;
                        },
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: subTilteTwoColor,
                        ),
                      ),
                    );
                  }),
              SizedBox(height: 10),
              Text(
                appString.ATLEAST,
                style: atlestStyle,
              ),
              Consumer(builder: (context, ref, _) {
                return ButtonWidget(
                    showCircle: isloading,
                    title: AppString().REGISTER,
                    ontap: () async {
                      if (_formKey.currentState!.validate() &&
                          _passwordError.value == null) {
                        setState(() {
                          isloading = true;
                        });
                        final result = await ref.read(userProvider).signUp({
                          'first_name': widget.firstName,
                          "last_name": widget.lastName,
                          'phone': widget.phone,
                          'birth_Date': dateController.text,
                          'password': passwordController.text,
                          'confirm_password': confirmeController.text,
                        });
                        if (result == true) {
                          await CheckUserStatus().getUserId(widget.phone);
                          core
                              .get<SharedPreferences>()
                              .setString('firstName', widget.firstName);
                          core
                              .get<SharedPreferences>()
                              .setString('lastName', widget.lastName);
                          core
                              .get<SharedPreferences>()
                              .setString('phone', widget.phone);
                          core
                              .get<SharedPreferences>()
                              .setString('date', dateController.text);
                          core
                              .get<SharedPreferences>()
                              .setString('password', passwordController.text);
                          core.get<SharedPreferences>().setString(
                              'confirmPassword', confirmeController.text);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IdPhotoUploaderScreen(),
                            ),
                          );
                          setState(() {
                            isloading = false;
                          });
                        } else {
                          setState(() {
                            isloading = false;
                          });
                          Text("There is an error");
                        }
                      }
                    },
                    color: darkPrimaryColor,
                    textColor: white,
                    borderColor: darkPrimaryColor,
                    width: MediaQuery.of(context).size.width);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
