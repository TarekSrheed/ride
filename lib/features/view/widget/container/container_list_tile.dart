import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';

class ContainerListTile extends StatelessWidget {
  ContainerListTile({
    super.key,
    this.trailing,
    this.leading,
    required this.subTilte,
    required this.title,
  });
  final Widget? trailing;
  final Widget? leading;
  final Widget subTilte;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(8),
        color: iconDisplayColor,
      ),
      child: ListTile(
        title: title,
        // subtitle: subTilte,
        trailing: trailing,
        leading: leading,
      ),
    );
  }
}
