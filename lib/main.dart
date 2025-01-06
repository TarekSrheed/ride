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
      url: 'url',
      anonKey:
          'key');
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
