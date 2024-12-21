import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_string.dart';
import 'package:ride_app/features/view/widget/button_widget.dart';

class ContainerAvaiableBikesWidget extends StatelessWidget {
  const ContainerAvaiableBikesWidget({
    super.key,
    required this.typeBikes,
    required this.specifications,
    required this.distance,
    required this.duration,
    required this.image,
  });
  final String typeBikes;
  final String specifications;
  final String distance;
  final String duration;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: darkPrimaryColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: darkPrimaryColor,
        ),
      ),
      child: Column(
        children: [
          Text(typeBikes),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(specifications),
              SizedBox(width: 50, height: 30, child: Image.asset(image)),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.location_on_sharp),
              Text('$distance(${duration}away)'),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ButtonWidget(
                  title: AppString().VIEW,
                  ontap: () {},
                  color: Colors.white.withOpacity(0),
                  textColor: darkPrimaryColor,
                  borderColor: darkPrimaryColor,
                  width: 45,
               
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
