import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  const Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BottomNavigationBar(
        items:const [
           BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Favourite',
          )
        ],
      ),
    );
  }
}
