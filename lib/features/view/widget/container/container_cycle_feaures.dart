import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_style.dart';

class ContainerCycleFeaures extends StatelessWidget {
  const ContainerCycleFeaures({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.width * 0.10,
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(8),
            color: iconDisplayColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: aboutUsTitleStyle,
              ),
              Text(
                subtitle,
                style: aboutUsTitleStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
