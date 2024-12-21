
import 'package:flutter/material.dart';

class ListTileRecentPlacesWidget extends StatelessWidget {
  const ListTileRecentPlacesWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailingText,
  });
  final String title;
  final String subtitle;
  final String trailingText;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading: const Icon(Icons.location_on),
      trailing: Text(trailingText),
      title: Text(
        title,
        maxLines: 1,
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
      ),
    );
  }
}
