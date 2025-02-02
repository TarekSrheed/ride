import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ride_app/core/config/service_locator.dart';
import 'package:ride_app/features/view/widget/container/show_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadIdCard {
  final supabase = Supabase.instance.client;

  Future<String?> uploadIDCard(File image) async {
    final fileName = 'user-id-card/${DateTime.now().toIso8601String()}.png';
    try {
      await supabase.storage.from('id-cards').upload(fileName, image);

      final url = supabase.storage.from('id-cards').getPublicUrl(fileName);
      print(url);
      return url;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> saveUserPhotoUrl(int userId, String photoUrl) async {
    try {
      await supabase
          .from('users')
          .update({'id_photo_url': photoUrl}).eq('id', userId);
    } catch (e) {
      throw Exception('Failed to save photo URL: $e');
    }
  }

  Future<bool> uploadPhotoToSupabase(
      {required BuildContext context, required File idPhoto}) async {
    final userId = core.get<SharedPreferences>().getInt('userId') as int;
    try {
      final photoUrl = await uploadIDCard(idPhoto);
      if (photoUrl != null) {
        await saveUserPhotoUrl(userId, photoUrl);
       
        return true;
      } else {
        throw Exception('Failed to upload the photo');
      }
    } catch (e) {
      throw Exception(e);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error: $e')),
      // );
    }
  }




}


class UploadPersonalPhoto {
  
 final supabase = Supabase.instance.client;

  

  Future<String?> uploadPersonalToStorage(File image) async {
    final fileName =
        'user-personal_photo/${DateTime.now().toIso8601String()}.png';
    try {
      await supabase.storage.from('personal_photo').upload(fileName, image);

      final url =
          supabase.storage.from('personal_photo').getPublicUrl(fileName);
      print(url);
      return url;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }




  Future<void> savePersonalPhotoUrl(int userId, String photoUrl) async {
    try {
      await supabase
          .from('users')
          .update({'personal_photo': photoUrl}).eq('id', userId);
    } catch (e) {
      throw Exception('Failed to save photo URL: $e');
    }
  }

  Future<bool> uploadPersonalPhoto(
      {required BuildContext context, required File idPhoto}) async {
    final userId = core.get<SharedPreferences>().getInt('userId') as int;
    try {
      final photoUrl = await uploadPersonalToStorage(idPhoto);
      if (photoUrl != null) {
        core.get<SharedPreferences>().setString('personalPhoto', photoUrl);
        await savePersonalPhotoUrl(userId, photoUrl);
        showSnackbar(context, Colors.green, "Photo added");
        return true;
      } else {
        throw Exception('Failed to upload the photo');
      }
    } catch (e) {
      throw Exception(e);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error: $e')),
      // );
    }
  }

}