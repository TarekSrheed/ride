import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
  });
  final String title;
  final String subtitle;
  final String time;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width / 0.5,
      child: ListTile(
        title: Text(
          title,
          maxLines: 1,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              maxLines: 2,
            ),
            Text(
              time,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
