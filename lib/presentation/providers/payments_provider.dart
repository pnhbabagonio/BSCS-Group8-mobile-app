import 'package:flutter/foundation.dart';
import 'package:psits_app/data/models/payment_model.dart';
import 'package:psits_app/data/models/requirement_model.dart';
import 'package:psits_app/services/supabase_service.dart';

class PaymentsProvider with ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  
  List<PaymentModel> _payments = [];
  List<PaymentModel> _pendingPayments = [];
  List<RequirementModel> _requirements = [];
  bool _isLoading = false;
  String? _error;

  List<PaymentModel> get payments => _payments;
  List<PaymentModel> get pendingPayments => _pendingPayments;
  List<RequirementModel> get requirements => _requirements;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadUserPayments(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final paymentsData = await _supabaseService.getPayments(userId);
      _payments = paymentsData.map((data) => PaymentModel.fromJson(data)).toList();
      
      final pendingData = await _supabaseService.getPendingPayments(userId);
      _pendingPayments = pendingData.map((data) => PaymentModel.fromJson(data)).toList();
    } catch (e) {
      _error = 'Failed to load payments: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadRequirements() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final requirementsData = await _supabaseService.getRequirements();
      _requirements = requirementsData.map((data) => RequirementModel.fromJson(data)).toList();
    } catch (e) {
      _error = 'Failed to load requirements: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePaymentStatus(String paymentId, String status) async {
    try {
      await _supabaseService.updatePaymentStatus(paymentId, status);
      // Reload payments after update
      // Note: You might want to pass userId here or manage it differently
    } catch (e) {
      _error = 'Failed to update payment: $e';
      notifyListeners();
    }
  }
}