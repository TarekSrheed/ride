import 'package:ride_app/core/config/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient client;

  AuthService(this.client);

  Future<bool> signUp(Map<String, String> user) async {
    try {
      final response = await client.from('users').insert(user);
      if (response == null) {
        return true;
      } else {
        print('Error inserting note: $response');
        return false;
      }
    } catch (e) {
      print('Exception inserting user: $e');
      return false;
    }
  }

  Future<int> getUserId(String phone) async {
    try {
      final response =
          await client.from('users').select('id').eq('phone', phone).single();
      final userId = response['id'] as int;
      core.get<SharedPreferences>().setInt('userId', userId);
      return userId;
    } catch (e) {
      throw Exception('Failed to get userId');
    }
  }

  Future<void> verifyAccount(int userID) async {
    final responseGet =
        await client.from('users').select('Balance').eq('id', userID).single();
    final currentBalance = responseGet['Balance'] as double;

    final responseUpdate = await client.from('Users').update({
      'AccountStatus': 'Verified',
      'Balance': currentBalance + 50000,
    }).eq('UserID', userID);

    if (responseUpdate != null) {
      throw Exception(responseUpdate);
    }
  }

//  Future<bool> getUser (int userId)async{
//    try{
// final response = await client.from('users').select().eq('id', userId).single();
// if (response == null) {

// } else {

// }
//    }catch(e){

//    }
//  }
}
