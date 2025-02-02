import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_images.dart';
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(
              fit: BoxFit.contain,
              imge6,
              width: double.infinity,
              height: 300,
            ),
            Text(
              AppString().WELCOME,
              style: titleStyle,
            ),
            const SizedBox(height: 10),
            Text(
              AppString().HAVEAETTER,
              style: subtitleStyle,
            ),
            ButtonWidget(
              topHeight: paddingHeight / 4,
              borderColor: darkPrimaryColor,
              color: darkPrimaryColor,
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SingUpView(),
                    ));
              },
              width: MediaQuery.of(context).size.width,
              textColor: white,
              title: AppString().CREATE,
            ),
            ButtonWidget(
              topHeight: 15,
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
          ],
        ),
      ),
    );
  }
}
