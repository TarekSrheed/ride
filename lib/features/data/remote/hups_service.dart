import 'package:supabase_flutter/supabase_flutter.dart';

class HupsService {
  final SupabaseClient client;
  HupsService(this.client);

  Future<List> getHups() async {
    try {
      final response = await client.from('hups').select();
      return response;
    } catch (e) {
      throw Exception('Failed to get Hups: $e');
    }
  }
}
