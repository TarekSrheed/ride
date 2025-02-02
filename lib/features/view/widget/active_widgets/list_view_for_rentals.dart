import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/features/view/widget/button_widget.dart';

class ContainerForRentals extends StatelessWidget {
  ContainerForRentals({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailing,
    // required this.itemCount,
    required this.ontap,
    required this.isCurrent,
    this.ontap1,
  });

  final String title;
  final String subtitle;
  bool isCurrent;
  final String trailing;
  // final int? itemCount;
  final void Function()? ontap;
  final void Function()? ontap1;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: primaryColor, width: 1)),
      child: ListTile(
        // onTap: ontap,
        title: Text(
          title,
          style: TextStyle(
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: grayColor,
          ),
        ),
        trailing: (isCurrent)
            ? ButtonWidget1(
                title: trailing,
                ontap:ontap1!,
                color: primaryColor,
                textColor: white,
                borderColor: primaryColor,
                width: 70,
                height: 30,
                titleSize: 13)
            : Text(
                trailing,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: blackColor),
              ),
      ),
    );
  }
}
