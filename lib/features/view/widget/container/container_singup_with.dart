import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';

class ContainerSingUpWithWidget extends StatelessWidget {
  const ContainerSingUpWithWidget({
    super.key,
    required this.image,
    required this.title,
  });
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: grayColor, width: 1),
            borderRadius: BorderRadius.circular(9)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image),
            Text(title),
          ],
        ),
      ),
    );
  }
}
