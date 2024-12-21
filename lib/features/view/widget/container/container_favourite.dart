
import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';

class ContainerFavourite extends StatelessWidget {
  ContainerFavourite({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: subTitleColor,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: const Icon(Icons.location_on_rounded),
        trailing: IconButton(
          icon: const Icon(
            Icons.remove_circle_rounded,
            color: Color.fromARGB(255, 170, 29, 19),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
