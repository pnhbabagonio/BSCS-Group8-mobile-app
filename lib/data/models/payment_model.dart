import 'package:equatable/equatable.dart';

class PaymentModel extends Equatable {
  final int id;
  final int? userId;
  final int requirementId;
  final double amountPaid;
  final DateTime? paidAt;
  final String status;
  final String? notes;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? studentId;
  final String? paymentMethod;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? requirement;

  const PaymentModel({
    required this.id,
    this.userId,
    required this.requirementId,
    required this.amountPaid,
    this.paidAt,
    required this.status,
    this.notes,
    this.firstName,
    this.middleName,
    this.lastName,
    this.studentId,
    this.paymentMethod,
    required this.createdAt,
    required this.updatedAt,
    this.requirement,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] as int,
      userId: json['user_id'] as int?,
      requirementId: json['requirement_id'] as int,
      amountPaid: (json['amount_paid'] as num).toDouble(),
      paidAt: json['paid_at'] != null
          ? DateTime.parse(json['paid_at'] as String)
          : null,
      status: json['status'] as String,
      notes: json['notes'] as String?,
      firstName: json['first_name'] as String?,
      middleName: json['middle_name'] as String?,
      lastName: json['last_name'] as String?,
      studentId: json['student_id'] as String?,
      paymentMethod: json['payment_method'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      requirement: json['requirements'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'requirement_id': requirementId,
      'amount_paid': amountPaid,
      'paid_at': paidAt?.toIso8601String(),
      'status': status,
      'notes': notes,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'student_id': studentId,
      'payment_method': paymentMethod,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  bool get isPending => status == 'pending';
  bool get isCompleted => status == 'completed';
  bool get isFailed => status == 'failed';

  String get requirementTitle => requirement?['title'] ?? 'Unknown Requirement';
  String? get requirementDescription => requirement?['description'];
  double get requirementAmount => requirement != null 
      ? (requirement!['amount'] as num).toDouble() 
      : 0.0;
  DateTime? get requirementDeadline => requirement?['deadline'] != null
      ? DateTime.parse(requirement!['deadline'] as String)
      : null;

  @override
  List<Object?> get props => [
    id,
    userId,
    requirementId,
    amountPaid,
    paidAt,
    status,
    notes,
    firstName,
    middleName,
    lastName,
    studentId,
    paymentMethod,
    createdAt,
    updatedAt,
    requirement,
  ];
}