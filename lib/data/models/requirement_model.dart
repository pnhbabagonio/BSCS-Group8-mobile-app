import 'package:equatable/equatable.dart';

class RequirementModel extends Equatable {
  final int id;
  final String title;
  final String? description;
  final double amount;
  final DateTime deadline;
  final int totalUsers;
  final int paid;
  final int unpaid;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RequirementModel({
    required this.id,
    required this.title,
    this.description,
    required this.amount,
    required this.deadline,
    required this.totalUsers,
    required this.paid,
    required this.unpaid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RequirementModel.fromJson(Map<String, dynamic> json) {
    return RequirementModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      amount: (json['amount'] as num).toDouble(),
      deadline: DateTime.parse(json['deadline'] as String),
      totalUsers: json['total_users'] as int,
      paid: json['paid'] as int,
      unpaid: json['unpaid'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'deadline': deadline.toIso8601String(),
      'total_users': totalUsers,
      'paid': paid,
      'unpaid': unpaid,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  double get progress => totalUsers > 0 ? paid / totalUsers : 0.0;
  bool get isOverdue => deadline.isBefore(DateTime.now());

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    amount,
    deadline,
    totalUsers,
    paid,
    unpaid,
    createdAt,
    updatedAt,
  ];
}