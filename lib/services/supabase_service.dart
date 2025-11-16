import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:psits_app/core/constants/env_constants.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  final SupabaseClient _client = SupabaseClient(
    EnvConstants.supabaseUrl,
    EnvConstants.supabaseAnonKey,
  );

  SupabaseClient get client => _client;

  Future<void> initialize() async {
    await Supabase.initialize(
      url: EnvConstants.supabaseUrl,
      anonKey: EnvConstants.supabaseAnonKey,
    );
  }

  // Auth methods
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> userData,
  }) async {
    return await _client.auth.signUp(
      email: email,
      password: password,
      data: userData,
    );
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  User? get currentUser => _client.auth.currentUser;

  // Database operations
  Future<List<Map<String, dynamic>>> getEvents() async {
    final response = await _client
        .from('events')
        .select('*')
        .order('date', ascending: true);
    return response;
  }

  Future<List<Map<String, dynamic>>> getUserEvents(String userId) async {
    final response = await _client
        .from('attendees')
        .select('''
          *,
          events (*)
        ''')
        .eq('user_id', userId);
    return response;
  }

  Future<List<Map<String, dynamic>>> getPayments(String userId) async {
    final response = await _client
        .from('payments')
        .select('''
          *,
          requirements (*)
        ''')
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return response;
  }

  Future<List<Map<String, dynamic>>> getPendingPayments(String userId) async {
    final response = await _client
        .from('payments')
        .select('''
          *,
          requirements (*)
        ''')
        .eq('user_id', userId)
        .eq('status', 'pending')
        .order('created_at', ascending: false);
    return response;
  }

  Future<List<Map<String, dynamic>>> getRequirements() async {
    final response = await _client
        .from('requirements')
        .select('*')
        .order('deadline', ascending: true);
    return response;
  }

  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response = await _client
        .from('users')
        .select()
        .eq('id', userId)
        .single();
    return response;
  }

  Future<void> updateUserProfile(String userId, Map<String, dynamic> data) async {
    await _client
        .from('users')
        .update(data)
        .eq('id', userId);
  }

  Future<void> registerForEvent(String userId, String eventId) async {
    await _client.from('attendees').insert({
      'user_id': userId,
      'event_id': eventId,
      'attendance_status': 'registered',
      'registered_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updatePaymentStatus(String paymentId, String status) async {
    await _client
        .from('payments')
        .update({
          'status': status,
          'paid_at': status == 'completed' ? DateTime.now().toIso8601String() : null,
        })
        .eq('id', paymentId);
  }
}