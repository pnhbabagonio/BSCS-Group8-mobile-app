import 'package:flutter/foundation.dart';
import 'package:psits_app/data/models/event_model.dart';
import 'package:psits_app/services/supabase_service.dart';

class EventsProvider with ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  
  List<EventModel> _events = [];
  List<EventModel> _userEvents = [];
  bool _isLoading = false;
  String? _error;

  List<EventModel> get events => _events;
  List<EventModel> get userEvents => _userEvents;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<EventModel> get upcomingEvents =>
      _events.where((event) => event.isUpcoming).toList();
  
  List<EventModel> get ongoingEvents =>
      _events.where((event) => event.isOngoing).toList();

  Future<void> loadEvents() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final eventsData = await _supabaseService.getEvents();
      _events = eventsData.map((data) => EventModel.fromJson(data)).toList();
    } catch (e) {
      _error = 'Failed to load events: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUserEvents(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final userEventsData = await _supabaseService.getUserEvents(userId);
      _userEvents = userEventsData
          .where((data) => data['events'] != null)
          .map((data) => EventModel.fromJson(data['events']))
          .toList();
    } catch (e) {
      _error = 'Failed to load user events: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> registerForEvent(String userId, String eventId) async {
    try {
      await _supabaseService.registerForEvent(userId, eventId);
      // Reload user events after registration
      await loadUserEvents(userId);
    } catch (e) {
      _error = 'Failed to register for event: $e';
      notifyListeners();
    }
  }
}