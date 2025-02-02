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

  Future<void> verifyAccount(int userID) async {
    final responseGet =
        await client.from('users').select('Balance').eq('id', userID).single();
    final currentBalance = responseGet['Balance'] as double;

    final responseUpdate = await client.from('Users').update({
      'AccountStatus': 'Verified',
      'Balance': currentBalance + 50000,
    }).eq('id', userID);

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

class CheckUserStatus {
  final supabase = Supabase.instance.client;

  Future<bool> logIn({required String password, required phone}) async {
    final response = await supabase
        .from('users')
        .select()
        .eq('phone', phone)
        .eq('password', password);
    if (response.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List> checkUserStatus({required int userId}) async {
    final response =
        await supabase.from('users').select('AccountStatus').eq('id', userId);
    return response;

    // final currentStatus = response['AccountStatus'];
    // if (currentStatus == 'Verified') {
    //   return true;
    // } else {
    //   return false;
    // }
  }

  Future<List> getUserData(String phone) async {
    try {
      final response = await supabase.from('users').select().eq('phone', phone);

      return response;
    } catch (e) {
      throw Exception('Failed to get userId');
    }
  }

  Future<int> getUserId(String phone) async {
    try {
      final response =
          await supabase.from('users').select().eq('phone', phone);
      final userId = response[0]['id'] as int;
      print(userId);
      final firstName = response[0]['first_name'] as String;
      print(firstName);
      final lastName = response[0]['last_name'] as String;
      final date = response[0]['birth_Date'] as String;
      final password = response[0]['password'] as String;
      final confirmPassword = response[0]['confirm_password'] as String;
      core.get<SharedPreferences>().setInt('userId', userId);
      core.get<SharedPreferences>().setString('firstName', firstName);
      core.get<SharedPreferences>().setString('lastName', lastName);
      core.get<SharedPreferences>().setString('phone', phone);
      core.get<SharedPreferences>().setString('date', date);
      core.get<SharedPreferences>().setString('password', password);
      core
          .get<SharedPreferences>()
          .setString('confirmPassword', confirmPassword);

      return userId;
    } catch (e) {
      throw Exception('Failed to get userId $e');
    }
  }

  Future<void> updatePhoneProfile(
      {required int userId, required String phone}) async {
    try {
      await supabase.from('users').update({
        'phone': phone,
      }).eq('id', userId);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<void> updatePasswordProfile(
      {required int userId,
      required String password,
      required String confirmPassword}) async {
    try {
      await supabase.from('users').update({
        'password': password,
        'confirm_password': confirmPassword,
      }).eq('id', userId);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<void> updateNameProfile(
      {required int userId,
      required String fistName,
      required String lastName}) async {
    try {
      await supabase.from('users').update({
        'first_name': fistName,
        'last_name': lastName,
      }).eq('id', userId);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<void> updateBirthDateProfile({
    required int userId,
    required String date,
  }) async {
    try {
      await supabase.from('users').update({
        'birth_Date': date,
      }).eq('id', userId);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<bool> checkPhoneNumberExists(String phone) async {
    try {
      final response = await supabase
          .from('users')
          .select('phone')
          .eq('phone', phone)
          .single();

      // إذا وجدنا رقم الهاتف
      if (response.isNotEmpty && response != null) {
        return true; // رقم الهاتف موجود
      } else {
        return false; // رقم الهاتف غير موجود
      }
    } catch (e) {
      // إذا حدث خطأ أثناء التحقق
      print('Error checking phone number: $e');
      return false;
    }
  }
}

Future<Map<String, dynamic>?> loginUser(String phone, String password) async {
  final supabase = Supabase.instance.client;
  try {
    final response =
        await supabase.from('users').select().eq('phone', phone).single();
    if (response.isEmpty || response == null) {
      throw Exception('User not found');
    }
    final userData = response;
    if (userData['password'] == password) {
      return userData;
    } else {
      throw Exception('Invalid password');
    }
  } catch (e) {
    print('Login Error: $e');
    return null;
  }
}
