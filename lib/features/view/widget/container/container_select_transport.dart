
import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_style.dart';

class ContainerWithBorderWithBackground extends StatelessWidget {
  ContainerWithBorderWithBackground({super.key, required this.widget, required this.text});
  final Widget widget;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 25,
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        color: iconDisplayColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: darkPrimaryColor,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           widget,
            SizedBox(height: 8),
            Text(text, style: titleFavoStyle),
          ],
        ),
      ),
    );
  }
}
