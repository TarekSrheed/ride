import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/core/config/secrets.dart';
import 'package:ride_app/core/config/service_locator.dart';
import 'package:ride_app/features/view/pages/authentication/onboarding_page.dart';
import 'package:ride_app/features/view/pages/navigation_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  await Supabase.initialize(
      url: Secrets.supabaseUrl, anonKey: Secrets.supabaseAnonKey);
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
        home: checkAuthorized() ? OnboardingView() : NavigationPage(),
      ),
    );
  }
}
