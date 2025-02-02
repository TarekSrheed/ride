import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClientProvider = Provider((ref) => Supabase.instance.client);

class PersonalPhotoNotifier extends StateNotifier<File?> {
  PersonalPhotoNotifier() : super(null);
  void updatePhoto(File photo) {
    state = photo;

  }

  void clearPhoto() {
    state = null;
  }
}

final   personalPhotoProvider = StateNotifierProvider<PersonalPhotoNotifier, File?>(
  (ref) => PersonalPhotoNotifier(),
);
