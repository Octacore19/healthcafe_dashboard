import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcafe_dashboard/data/local/model/assessment/assessment.dart';

class AssessmentResponse {
  final String? id;
  final String? name;
  final String? description;
  final List<String>? questions;
  final Timestamp? createdAt;
  final String? createdBy;
  final Timestamp? updatedAt;
  final String? updatedBy;

  AssessmentResponse._({
    this.id,
    this.name,
    this.description,
    this.questions,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  factory AssessmentResponse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final json = snapshot.data();
    return AssessmentResponse._(
      id: snapshot.id,
      name: json?['name'],
      description: json?['description'],
      createdAt: json?['created_at'],
      updatedAt: json?['updated_at'],
      createdBy: json?['created_by'],
      updatedBy: json?['updated_by'],
      questions: List.from(json?['questions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'created_at': createdAt,
      'created_by': createdBy,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
      'questions': questions,
    };
  }

  HiveAssessment get toHive {
    return HiveAssessment()
      ..id = id
      ..name = name
      ..description = description
      ..questions = questions
      ..createdBy = createdBy
      ..createdAt = createdAt?.toDate().toIso8601String()
      ..updatedBy = updatedBy
      ..updatedAt = updatedAt?.toDate().toIso8601String();
  }
}
