
import 'package:flutter/material.dart';

class ListTileRequestRent extends StatelessWidget {
  const ListTileRequestRent(
      {super.key,
      this.trailing,
      required this.title,
      required this.subTitle,
      required this.color});
  final String title;
  final String subTitle;
  final String? trailing;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.location_on_rounded,
        color: color,
      ),
      title: Text(title),
      subtitle: Text(subTitle),
      trailing: Text(trailing ?? ''),
    );
  }
}
