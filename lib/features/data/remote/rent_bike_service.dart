import 'package:supabase_flutter/supabase_flutter.dart';

class RentBikeService {
  final SupabaseClient supabase;

  RentBikeService(this.supabase);
  Future<void> rentBike(
      int userId, int bikeId, int endLocationId, int rentalCost) async {

    final bikeResponse = await supabase
        .from('bicycles')
        .select('CurrentLocationID')
        .eq('id', bikeId)
        .single();
    final startLocationId = bikeResponse['CurrentLocationID'] as double;

    final userResponse = await supabase
        .from('users')
        .select('Balance')
        .eq('id', userId)
        .single();
    final currentBalance = userResponse['Balance'] as double;
    if (currentBalance < rentalCost) {
      throw Exception('Insufficient balance for rental.');
    }
    final responseUpdate = await supabase.from('Users').update({
      'Balance': currentBalance - rentalCost,
    }).eq('UserID', userId);

    if (responseUpdate != null) {
      throw Exception(responseUpdate);
    }

    final rentalResponse = await supabase.from('rentals').insert({
      'userId': userId,
      'bikeId': bikeId,
      "startLocationID": startLocationId,
      'endLocationID': endLocationId,
      'totalprice': rentalCost,
      'startTime': DateTime.now().toIso8601String(),
    }).select();
    if (rentalResponse != null) {
      throw Exception(rentalResponse);
    }
    final updateBikeResponse = await supabase.from('bicycles').update({
      'status': 'In Use',
      'CurrentLocationID': endLocationId,
    }).eq('id', bikeId);
    if (updateBikeResponse != null) {
      throw Exception(responseUpdate);
    }
  }
}
