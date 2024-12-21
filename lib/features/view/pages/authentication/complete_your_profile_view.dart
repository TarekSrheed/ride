import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/features/view/widget/button_widget.dart';

import '../../../../core/res/app_color.dart';
import '../../../../core/res/app_string.dart';

class CompleteYourProfile extends StatefulWidget {
  // final String phone;
  // final String firstName;
  // final String lastName;
  // final String confirmPassword;
  // final String password;

  const CompleteYourProfile({
    super.key,
    // required this.phone,
    // required this.confirmPassword,
    // required this.password,
    // required this.firstName,
    // required this.lastName,
  });

  @override
  State<CompleteYourProfile> createState() => _CompleteYourProfileState();
}

class _CompleteYourProfileState extends State<CompleteYourProfile> {
  final AppString appString = AppString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appString.PROFILE),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 90,
                    backgroundColor: hintColor,
                  ),
                  Positioned(
                    top: 125,
                    left: 125,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: darkPrimaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                    title: appString.CANCEL,
                    ontap: () {},
                    color: darkPrimaryColor.withOpacity(0),
                    textColor: blackColor,
                    borderColor: darkPrimaryColor,
                    width: MediaQuery.of(context).size.width * 0.4),
                const SizedBox(width: 15),

                Consumer(builder: (context, ref, _) {
                  return ButtonWidget(
                      title: AppString().SAVE,
                      ontap: () async {},
                      color: darkPrimaryColor,
                      textColor: white,
                      borderColor: darkPrimaryColor,
                      width: MediaQuery.of(context).size.width * 0.4);
                }),

                //  );
              ],
            ),
          ],
        ),
      ),
    );
  }
}
