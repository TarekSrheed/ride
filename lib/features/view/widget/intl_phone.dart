import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_string.dart';
import 'package:ride_app/core/res/app_style.dart';

class IntlPhoneFildWidget extends StatelessWidget {
  const IntlPhoneFildWidget({
    super.key,
    required this.phoneController,
  });
  final TextEditingController phoneController;
  @override
  Widget build(BuildContext context) {
// <<<<<<< HEAD
    // return IntlPhoneField(
    //   controller: phoneController,
    //   decoration: const InputDecoration(
    //     labelText: 'Phone Number',
    //     border: OutlineInputBorder(
    //       borderSide: BorderSide(),
// =======
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextField(
        controller: phoneController,
        decoration: InputDecoration(
          labelStyle: hintStyle,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: darkPrimaryColor,
            ),
          ),

          labelText: AppString().YOURMOBILE,
          border: const OutlineInputBorder(),

// >>>>>>> 754d5ae7bccc02137f2eb8df2fa5bc6f5d950513
        ),
      ),
    );
  }
}
