import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String location;
  final int capacity;
  final String category;
  final String status;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.capacity,
    required this.category,
    required this.status,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      location: json['location'] as String,
      capacity: json['capacity'] as int,
      category: json['category'] as String,
      status: json['status'] as String,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'time': time,
      'location': location,
      'capacity': capacity,
      'category': category,
      'status': status,
      'deleted_at': deletedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  bool get isUpcoming => status == 'upcoming';
  bool get isOngoing => status == 'ongoing';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    date,
    time,
    location,
    capacity,
    category,
    status,
    deletedAt,
    createdAt,
    updatedAt,
  ];
}