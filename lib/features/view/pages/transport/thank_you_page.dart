import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_images.dart';
import 'package:ride_app/core/res/app_string.dart';
import 'package:ride_app/features/view/pages/navigation_pages.dart';
import 'package:ride_app/features/view/widget/button_widget.dart';
import 'package:ride_app/features/view/widget/text_tilte.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(thank),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: TextTilte(text: AppString().THANKYOU),
            ),
            Text(AppString().YOURBOOKINGHAS),
            const SizedBox(
              height: 200,
            ),
            ButtonWidget(
              title: 'OK',
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationPage(),
                  ),
                );
              },
              color: primaryColor,
              textColor: white,
              borderColor: primaryColor,
              width: MediaQuery.of(context).size.width - 20,
            ),
          ],
        ),
      ),
    );
  }
}
