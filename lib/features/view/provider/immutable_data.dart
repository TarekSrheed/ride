import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/features/data/remote/auth_service.dart';
import 'package:ride_app/features/data/remote/bike_service.dart';
import 'package:ride_app/features/data/remote/rent_bike_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClientProvider = Provider((ref) => Supabase.instance.client);

final userProvider = Provider<AuthService>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return AuthService(supabase);
});



final availableBikeProvider =
    FutureProvider.autoDispose.family<List, int>((ref, locationId) async {
  final supabase = ref.watch(supabaseClientProvider);
  return BikeService(supabase).getAvailableBikes(locationId);
});

final walletProvider =
    FutureProvider.autoDispose.family<List, int>((ref, userId) async {
  return RentBikeService().checkBalance(userId: userId);
});

final hupsProvider = FutureProvider((ref) async {
  final supabase = ref.watch(supabaseClientProvider);
  final result = await supabase.from('hups').select();
  return result;
  // return HupsService(supabase);
});


final userDataProvider = FutureProvider((ref) async {
  final supabase = ref.watch(supabaseClientProvider);
  final result = await supabase.from('hups').select();
  return result;
  // return HupsService(supabase);
});


final rentalsProvider =
    FutureProvider.autoDispose.family<List, int>((ref, userId) async {
  return RentBikeService().getRentals(userId: userId);
});

final allRentalsProvider =
    FutureProvider.autoDispose.family<List, int>((ref, userId) async {
  return RentBikeService().getAllRentals(userId: userId);
});

final currentRentalsProvider =
    FutureProvider.autoDispose.family<List, int>((ref, userId) async {
  return RentBikeService().getCurrentRentals(userId: userId);
});

// final checkUserStatusProvider =
//     Provider.autoDispose.family<dynamic, int>((ref, userId) {
//   final supabase = ref.watch(supabaseClientProvider);
//   final result = AuthService(supabase).checkUserStatus(userId: userId);
//   return result;
// });




// class Photo extends StateNotifier {
//   Photo(super.state);
// }

// final rentBikeProvider = Provider<RentBikeService>((ref) {
//   final supabase = ref.watch(supabaseClientProvider);
//   return RentBikeService(supabase);
// });
