import 'package:equatable/equatable.dart';
import 'package:healthcafe_dashboard/data/local/model/assessment/assessment.dart';

class Assessment extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<String> questions;
  final DateTime? createdAt;
  final String createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;

  const Assessment._({
    required this.id,
    required this.name,
    required this.description,
    required this.questions,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
  });

  factory Assessment.empty() {
    return const Assessment._(
      id: '',
      name: '',
      description: '',
      questions: [],
      createdAt: null,
      createdBy: '',
      updatedAt: null,
      updatedBy: '',
    );
  }

  factory Assessment.fromHive(HiveAssessment? hive) {
    return Assessment._(
      id: hive?.id ?? '',
      name: hive?.name ?? '',
      description: hive?.description ?? '',
      questions: hive?.questions ?? [],
      createdAt:
          hive?.createdAt == null ? null : DateTime.tryParse(hive!.createdAt!),
      createdBy: hive?.createdBy ?? '',
      updatedAt:
          hive?.updatedAt == null ? null : DateTime.tryParse(hive!.updatedAt!),
      updatedBy: hive?.updatedBy ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        questions,
        createdAt,
        createdBy,
        updatedAt,
        updatedBy,
      ];
}
