import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_string.dart';
import 'package:ride_app/core/res/app_style.dart';

class AddIdPage extends StatelessWidget {
   AddIdPage({super.key});

  final AppString appString = AppString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(
          appString.ADDID,
          style: titleStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
    );
  }
}