import 'dart:convert';

import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:healthcafe_dashboard/data/local/model/base_model.dart';
import 'package:hive/hive.dart';

part 'assessment.g.dart';

@HiveType(typeId: assessmentId, adapterName: 'AssessmentAdapter')
class HiveAssessment extends HiveObject with BaseModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  List<String>? questions;

  @HiveField(4)
  String? createdAt;

  @HiveField(5)
  String? createdBy;

  @HiveField(6)
  String? updatedAt;

  @HiveField(7)
  String? updatedBy;

  @override
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

  @override
  String toString() => jsonEncode(toJson());
}
