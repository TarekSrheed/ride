import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/core/config/service_locator.dart';
import 'package:ride_app/features/view/pages/authentication/welcome_view.dart';
import 'package:ride_app/features/view/pages/map_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  await Supabase.initialize(
      url: 'https://lujukofdovfacdpxwwqj.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx1anVrb2Zkb3ZmYWNkcHh3d3FqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE0OTc5ODUsImV4cCI6MjA0NzA3Mzk4NX0.qTTVeKVAvh7o_b4wNuydr6C5lfDm1PZiwSG2uDVrouE');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  bool checkAuthorized() {
    final prefs = core.get<SharedPreferences>();
    int? userId = prefs.getInt('userId');
    return userId == null;
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: checkAuthorized() ? WelcomView() : MapScreen(),
      ),
    );
  }
}
