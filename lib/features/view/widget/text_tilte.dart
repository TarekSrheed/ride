
import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_style.dart';

class TextTilte extends StatelessWidget {
  TextTilte({
    required this.text,
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: titleStyle,
    );
  }
}