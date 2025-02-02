import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_style.dart';

class TextFromFildWidget extends StatelessWidget {
  TextFromFildWidget({
    super.key,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.textInputType,
    this.validator,
    this.onChanged,
    this.hintText,
    this.height,
    this.errorText,
    this.inputFormatters,
    required this.readOnly,
    required this.obscureText,
    required this.controller,
    required this.lableText,
  });
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String lableText;
  final String? hintText;
  double? height = 60;
  final String? errorText;
  final bool readOnly;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final Function(String)? onChanged;
  List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        onChanged: onChanged,
        obscureText: obscureText,
        validator: validator,
        keyboardType: textInputType,
        inputFormatters: inputFormatters,
        readOnly: readOnly,
        onTap: onTap,
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          errorText: errorText,
          labelText: lableText,
          hintText: hintText,
          labelStyle: hintStyle,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: subTilteTwoColor, width: 2.0),
            borderRadius: BorderRadius.circular(8),
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
