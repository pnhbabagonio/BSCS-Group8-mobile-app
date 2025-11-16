import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? studentId;
  final String? program;
  final String? year;
  final String role;
  final String status;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final DateTime? lastLogin;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.studentId,
    this.program,
    this.year,
    required this.role,
    required this.status,
    this.firstName,
    this.middleName,
    this.lastName,
    this.lastLogin,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      studentId: json['student_id'] as String?,
      program: json['program'] as String?,
      year: json['year'] as String?,
      role: json['role'] as String,
      status: json['status'] as String,
      firstName: json['first_name'] as String?,
      middleName: json['middle_name'] as String?,
      lastName: json['last_name'] as String?,
      lastLogin: json['last_login'] != null 
          ? DateTime.parse(json['last_login'] as String)
          : null,
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'student_id': studentId,
      'program': program,
      'year': year,
      'role': role,
      'status': status,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'last_login': lastLogin?.toIso8601String(),
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName ${middleName ?? ''} $lastName'.trim().replaceAll('  ', ' ');
    }
    return name;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    studentId,
    program,
    year,
    role,
    status,
    firstName,
    middleName,
    lastName,
    lastLogin,
    emailVerifiedAt,
    createdAt,
    updatedAt,
  ];
}