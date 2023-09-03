class AssessmentRequest {
  final String name;
  final String? description;
  final List<String> questions;

  AssessmentRequest({
    required this.name,
    this.description,
    required this.questions,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (description != null) 'description': description,
      'questions': questions,
    };
  }
}
