import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/features/data/remote/upload_id.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClientProvider = Provider((ref) => Supabase.instance.client);

class IdPhotoNotifier extends StateNotifier<File?> {
  IdPhotoNotifier() : super(null);
  void updatePhoto(File photo) {
    state = photo;

  }

  void clearPhoto() {
    state = null;
  }
}

final   idPhotoProvider = StateNotifierProvider<IdPhotoNotifier, File?>(
  (ref) => IdPhotoNotifier(),
);
