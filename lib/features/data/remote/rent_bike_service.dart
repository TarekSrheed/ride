import 'package:supabase_flutter/supabase_flutter.dart';

class RentBikeService {
  // final SupabaseClient supabase;
  // RentBikeService(this.supabase);
  final supabase = Supabase.instance.client;

  Future<void> rentBike(
      {required int userId,
      required int bikeId,
      required int endLocationId,
      required String bikeName,
      required String startLocationName,
      required String endLocationName,
      required double rentalCost,
      required int startLocationId}) async {
    final rentalResponse = await supabase.from('rentals').insert({
      'userId': userId,
      'bikeId': bikeId,
      "startLocationID": startLocationId,
      'endLocationID': endLocationId,
      'totalprice': rentalCost,
      'status': 'ongoing',
      'bike_name': bikeName,
      'start_location_name': startLocationName,
      'end_location_name': endLocationName,
      'startTime': DateTime.now().toIso8601String(),
    });

    if (rentalResponse != null) {
      throw Exception(rentalResponse);
    } else {
      final result = await checkBalance(userId: userId);
      final currentBalance = await result[0]['Balance'];
      if (currentBalance < rentalCost) {
        throw Exception();
      } else {
        final responseUpdate = await supabase.from('users').update({
          'Balance': currentBalance - rentalCost,
        }).eq('id', userId);
        if (responseUpdate != null) {
          throw Exception(responseUpdate);
        }
      }
    }
    final updateBikeResponse = await supabase.from('bicycles').update({
      'status': 'In Use',
      // 'CurrentLocationID': endLocationId,
    }).eq('id', bikeId);
    if (updateBikeResponse != null) {
      throw Exception(updateBikeResponse);
    }
  }

  Future<List> checkBalance({
    required int userId,
  }) async {
    final userResponse =
        await supabase.from('users').select('Balance').eq('id', userId);

    return userResponse;
  }

  Future<List> getRentals({required int userId}) async {
    try {
      final userResponse = await supabase
          .from('rentals')
          .select()
          .eq('userId', userId)
          .eq('status', 'finished');

      return userResponse;
    } catch (e) {
      throw Exception('Failed to get rentals: $e');
    }
  }

    Future<List> getAllRentals({required int userId}) async {
    try {
      final userResponse = await supabase
          .from('rentals')
          .select()
          .eq('userId', userId);
          

      return userResponse;
    } catch (e) {
      throw Exception('Failed to get rentals: $e');
    }
  }

  Future<List> getCurrentRentals({required int userId}) async {
    try {
      final userResponse = await supabase
          .from('rentals')
          .select()
          .eq('userId', userId)
          .eq('status', 'ongoing');

      return userResponse;
    } catch (e) {
      throw Exception('Failed to get rentals: $e');
    }
  }

  Future finishTheRent({
    required int userId,
    required int bikeId,
    required int endLocationId,
  }) async {
    try {
      final updateBikeResponse = await supabase.from('bicycles').update({
        'status': 'Available',
        'current_location_id': endLocationId,
      }).eq('id', bikeId);

      final userResponse = await supabase.from('rentals').update({
        'status': 'finished',
      }).eq('userId', userId);

      if (updateBikeResponse != null && userResponse != null) {
        throw Exception(updateBikeResponse);
      }
    } catch (e) {
      throw Exception('Failed to update rentals: $e');
    }
  }
}
