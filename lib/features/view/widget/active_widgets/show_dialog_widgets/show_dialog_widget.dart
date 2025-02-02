import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/features/view/widget/button_widget.dart';

void showDialog1(BuildContext context, String title, String subtitle, ) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title,
                style: TextStyle(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.w400,
                    fontSize: 25)),
            content:  Text(
              subtitle,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            ),
            actionsPadding:
                const EdgeInsets.only(left: 40, right: 40, bottom: 30),
            actions: [
              ButtonWidget1(
                titleSize: 20,
                height: 50,
                title: 'OK',
                ontap: () {
                  Navigator.pop(context);
                },
                color: primaryColor,
                textColor: const Color.fromARGB(255, 6, 3, 3),
                borderColor: primaryColor,
                width: double.infinity,
              ),
            ],
          );
        });
  }



