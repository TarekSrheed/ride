import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_style.dart';

class ContainerSpecifications extends StatelessWidget {
  const ContainerSpecifications({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });
  final String image;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Container(
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 0.17,
          height: MediaQuery.of(context).size.width * 0.16,
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(8),
            color: iconDisplayColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(image),
              Text(
                title,
                style: titleSpecifications,
              ),
              Text(
                subtitle,
                style: subTitleSpecifications,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
