import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_string.dart';
import 'package:ride_app/features/view/widget/button_widget.dart';

class AvaiableCycleList extends StatelessWidget {
  const AvaiableCycleList({
    super.key,
    required this.nameCycle,
    required this.feature1,
    required this.feature2,
    // required this.image,
    required this.ontap1,
    required this.price,
  });

  final String nameCycle;
  final String price;
  final String feature1;
  final String feature2;
  // final String image;
  final void Function() ontap1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 2,
              offset: const Offset(0, 1),
              color: Colors.green.shade600),
        ],
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(8),
        color: iconDisplayColor,
      ),
      child: ListTile(
        title: Text(
          nameCycle,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Price: $price"),
            Text(
              '$feature1 | $feature2',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: ButtonWidget1(
          height: 50,
            title: AppString().RIDENOW,
            ontap: ontap1,
            titleSize: 12,
            color: primaryColor,
            textColor: white,
            borderColor: primaryColor,
            width: 70),
      ),
    );

    // SizedBox(
    //   width: 150,
    //   height: 80,
    //   child: Image.network(
    //     'https://$image',
    //     headers: {
    //       'Authorization':
    //           'Bearer ${core.get<SharedPreferences>().getString('token')}'
    //     },
    //   ),
    // ),
  }
}
