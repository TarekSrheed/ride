import 'package:supabase_flutter/supabase_flutter.dart';

class BikeService {
  final SupabaseClient client;

  BikeService(this.client);

  Future<List> getAvailableBikes(int locationId) async {
    try {
      final response = await client
          .from('bicycles')
          .select()
          .eq('status', 'Available')
          .eq('CurrentLocationID', locationId);

      return response;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

// Future<void> returnBike(int rentalID, int bikeID) async {
//   final response = await client.rpc('update_bike_location', params: {
//     'rental_id': rentalID,
//     'bike_id': bikeID,
//   });

//   if (response.error != null) {
//     throw Exception(response.error?.message);
//   }
// }
}
