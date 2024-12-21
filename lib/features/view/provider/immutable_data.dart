import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/features/data/remote/auth_service.dart';
import 'package:ride_app/features/data/remote/bike_service.dart';
import 'package:ride_app/features/data/remote/rent_bike_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClientProvider = Provider((ref) => Supabase.instance.client);

final userProvider = Provider<AuthService>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  // final supabaseClient = Supabase.instance.client;
  return AuthService(supabase);
});

final availableBikeProvider =
    FutureProvider.autoDispose<BikeService>((ref) async {
  final supabase = ref.watch(supabaseClientProvider);
  return BikeService(supabase);
});

class Photo extends StateNotifier {
  Photo(super.state);
}

final rentBikeProvider = Provider<RentBikeService>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return RentBikeService(supabase);
});
