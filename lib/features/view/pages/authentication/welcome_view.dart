import 'package:flutter/material.dart';
import 'package:ride_app/features/view/pages/authentication/sign_in.dart';
import 'package:ride_app/features/view/pages/authentication/sign_up.dart';
import '../../../../core/res/app_color.dart';
import '../../../../core/res/app_string.dart';
import '../../../../core/res/app_style.dart';
import '../../widget/button_widget.dart';

class WelcomView extends StatelessWidget {
  const WelcomView({super.key});

  @override
  Widget build(BuildContext context) {
    double paddingWidth = MediaQuery.of(context).size.width;
    double paddingHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(paddingWidth * 0.02),
        child: Column(
          children: [
            // Image.asset(welcomeImage),
            Text(
              AppString().WELCOME,
              style: titleStyle,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: paddingHeight * 0.03, bottom: paddingHeight * 0.25),
              child: Text(
                AppString().HAVEAETTER,
                style: subtitleStyle,
              ),
            ),
            ButtonWidget(
              borderColor: darkPrimaryColor,
              color: darkPrimaryColor,
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  const SingUpView(),
                    ));
              },
              width: MediaQuery.of(context).size.width,
              textColor: white,
              title: AppString().CREATE,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: paddingHeight * 0.001, top: paddingHeight * 0.03),
              child: ButtonWidget(
                borderColor: darkPrimaryColor,
                color: Colors.black.withOpacity(0),
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SingInView(),
                      ));
                },
                width: MediaQuery.of(context).size.width,
                textColor: darkPrimaryColor,
                title: AppString().LOGIN,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
