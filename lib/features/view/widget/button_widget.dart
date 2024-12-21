import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.title,
    required this.ontap,
    required this.color,
    required this.textColor,
    required this.borderColor,
    required this.width,
    // required this.height,
  });
  final String title;
  final void Function() ontap;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double width;
  // final double height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
      child: InkWell(
        onTap: ontap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: width,
          decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(8),
              color: color),
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
