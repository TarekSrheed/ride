// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_style.dart';
import 'package:ride_app/features/view/pages/ranlals_pages/current_rent_page.dart';
import 'package:ride_app/features/view/pages/ranlals_pages/rentals_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Rentals",
            style: titleStyle,
          ),
          // leading: const Icon(Icons.menu),
          // actions: const [Icon(Icons.notifications)],
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: blackColor,

            indicatorPadding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            indicatorSize: TabBarIndicatorSize.tab,

            indicator: BoxDecoration(
              border: Border.all(color: grayColor, width: 1),
              color: primaryColor,
              borderRadius: BorderRadius.circular(15),
            ),

            // indicatorColor: primaryColor,
            // dividerColor: primaryColor,
            // labelStyle: labalStyle,

            // unselectedLabelStyle: lableItemUnselectedStyle,
            tabs: [
              Tab(text: "Current Rents"),
              Tab(text: "Completed"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CurrentRentPage(),
            RentalsPage(),
          ],
        ),
      ),
    );
  }
}
