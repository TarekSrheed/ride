import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    super.key,
    required this.title,
    required this.ontap,
    required this.color,
    required this.textColor,
    required this.borderColor,
    required this.width,
    this.showCircle = false,
    this.topHeight = 60,
    // required this.height,
  });
  final String title;
  final void Function() ontap;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double width;
  final bool showCircle;
  double topHeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: topHeight),
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
            child: (showCircle == false)
                ? Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : const CircularProgressIndicator(
                    color: Colors.white,
                  )),
      ),
    );
  }
}

class ButtonWidget1 extends StatelessWidget {
  const ButtonWidget1({
    super.key,
    required this.title,
    required this.ontap,
    required this.color,
    required this.textColor,
    required this.borderColor,
    required this.width,
    required this.height,
    required this.titleSize,
    this.showCircle = false,
  });
  final String title;
  final void Function() ontap;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final bool showCircle;
  final double width;
  final double titleSize;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: height,
          alignment: Alignment.center,
          width: width,
          decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(8),
              color: color),
          child: (showCircle == false)
              ? Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : const CircularProgressIndicator(
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
