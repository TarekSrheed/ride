import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_string.dart';

class CustomTabbar extends StatefulWidget {
  const CustomTabbar({super.key});

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar>
    with SingleTickerProviderStateMixin {
  late final TabController tabBarController;
  List<Widget> tabs = [
    const Text('TRANSPORT'),
    Text(AppString().DELIVERY),
  ];

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(
      length: 2,
      vsync: this,
    );
    tabBarController.addListener(() {
      tabBarController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBar(
          tabs: [
            const Text('TRANSPORT'),
            InkWell(
              onTap: (){
                // Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => SelectTransport(),
                //         ),
                //       );
              },
              child: Text(AppString().DELIVERY)),
          ],
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          unselectedLabelColor: titleColor,
          dividerColor: excellentColor,
          controller: tabBarController,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: darkPrimaryColor),
        ),
      ),
    );
  }
}

