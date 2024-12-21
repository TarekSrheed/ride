
import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';

class ContainerDrwer extends StatelessWidget {
  const ContainerDrwer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10),
      decoration: BoxDecoration(
          color: iconDisplayColor, borderRadius: BorderRadius.circular(8)),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.density_medium,
        ),
      ),
    );
  }
}
