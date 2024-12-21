import 'package:flutter/material.dart';

class CustomdRawer extends StatelessWidget {
  const CustomdRawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      width: 249,
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(80),
          bottomRight: Radius.circular(80),
        ),
        child: DrawerContent(),
      ),
    );
  }
}

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(onTap: () {}, child: const Icon(Icons.arrow_back)),
                  const SizedBox(width: 10),
                  const Text(
                    'back',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  )
                ],
              ),
            ),
          ),
          const UserAccountsDrawerHeader(
            accountName:
                Text('Nate Samson', style: TextStyle(color: Colors.black)),
            accountEmail:
                Text('nate@email.com', style: TextStyle(color: Colors.black)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50, color: Colors.black),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            margin: EdgeInsets.only(bottom: 10),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Complain'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Referral'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Us'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help and Support'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
            
                  // context.read<AppManagerBloc>().add(LogOut());
            },
          ),
        ],
      ),
    );
  }
}
