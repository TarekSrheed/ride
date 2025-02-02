import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_style.dart';
import 'package:ride_app/features/view/pages/map/map_page.dart';
import 'package:ride_app/features/view/pages/profile/profile_page.dart';
import 'package:ride_app/features/view/pages/ranlals_pages/main_page.dart';
import 'package:ride_app/features/view/pages/wallet/wallet_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  List<Widget> pages = [
    MapScreen(),
    WalletPage(),
    const MainPage(),
    ProfilePage(),
  ];
  int selectedPage = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(selectedPage),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: white,
        color: primaryColor,
        key: _bottomNavigationKey,
        items: [
          CurvedNavigationBarItem(
            labelStyle: labalStyle,
            child: Icon(
              Icons.home_outlined,
              color: white,
            ),
            label: 'home',
          ),
          CurvedNavigationBarItem(
            labelStyle: labalStyle,
            child: Icon(
              Icons.wallet_outlined,
              color: white,
              size: 24,
            ),
            label: "Wallet",
          ),
          CurvedNavigationBarItem(
            labelStyle: labalStyle,
            child: Icon(
              Icons.pedal_bike,
              color: white,
            ),
            label: "Rentals",
          ),
          CurvedNavigationBarItem(
            labelStyle: labalStyle,
            child: Icon(
              Icons.person_outline,
              color: white,
            ),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
