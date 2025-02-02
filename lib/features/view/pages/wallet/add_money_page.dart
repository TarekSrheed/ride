import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_images.dart';
import 'package:ride_app/core/res/app_string.dart';
import 'package:ride_app/core/res/app_style.dart';
import 'package:ride_app/features/view/widget/button_widget.dart';
import 'package:ride_app/features/view/widget/container/container_list_tile.dart';
import 'package:ride_app/features/view/widget/text_from_fild_widget.dart';

class AddMoneyPage extends StatelessWidget {
  AddMoneyPage({super.key});
  final TextEditingController enterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString().AMOUNT,
          style: titleStyle,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFromFildWidget(
              height: 55,
              obscureText: false,
              readOnly: false,
              controller: enterController,
              lableText: AppString().ENTERAMOUNT,
            ),
            const SizedBox(
              height: 10,
            ),
            // Align(
            //   alignment: Alignment.topRight,
            //   child: TextButton(
            //     onPressed: () {},
            //     child: Text(
            //       AppString().ADDPAYMENTMETHOD,
            //       style: const TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w500,
            //         color: Color(0xff304FFE),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: Text(
                AppString().SELECTPAYMENTMETHOD,
                style: titleFavoStyle,
              ),
            ),
            ContainerListTile(
              title: const Text('MTN Cash'),
              subTilte: const Text('Expires: 12/26'),
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/mtn.jpg',
                  )),
            ),
            ContainerListTile(
              title: const Text('Syriatel Cash'),
              subTilte: const Text(''),
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/syriatel.jpg',
                    width: 50,
                  )),
            ),

            // ContainerListTile(
            //   subTilte: const Text('Expires: 12/26'),
            //   title: const Text('**** **** **** 8970'),
            //   leading: Image.asset(payment3),
            // ),
            ButtonWidget(
              topHeight: MediaQuery.sizeOf(context).height / 4,
              title: AppString().CONFIRM,
              ontap: () {},
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
