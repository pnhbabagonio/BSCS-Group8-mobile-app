import 'package:flutter/foundation.dart';
import 'package:psits_app/data/models/user_model.dart';
import 'package:psits_app/services/supabase_service.dart';

class AuthProvider with ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _currentUser != null;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _supabaseService.initialize();
      
      // Check if user is already logged in
      final currentUser = _supabaseService.currentUser;
      if (currentUser != null) {
        await _loadUserProfile(currentUser.id);
      }
    } catch (e) {
      _error = 'Failed to initialize app: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _supabaseService.signIn(
        email: email,
        password: password,
      );

      if (response.user != null) {
        await _loadUserProfile(response.user!.id);
        return true;
      } else {
        _error = 'Login failed. Please check your credentials.';
        return false;
      }
    } catch (e) {
      _error = 'Login failed: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String studentId,
    required String program,
    required String year,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final userData = {
        'name': '$firstName $lastName',
        'first_name': firstName,
        'last_name': lastName,
        'student_id': studentId,
        'program': program,
        'year': year,
        'role': 'Member',
        'status': 'active',
      };

      final response = await _supabaseService.signUp(
        email: email,
        password: password,
        userData: userData,
      );

      if (response.user != null) {
        // User created successfully
        return true;
      } else {
        _error = 'Registration failed. Please try again.';
        return false;
      }
    } catch (e) {
      _error = 'Registration failed: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _supabaseService.signOut();
      _currentUser = null;
    } catch (e) {
      _error = 'Logout failed: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadUserProfile(String userId) async {
    try {
      final userData = await _supabaseService.getUserProfile(userId);
      if (userData != null) {
        _currentUser = UserModel.fromJson(userData);
      }
    } catch (e) {
      _error = 'Failed to load user profile: $e';
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}