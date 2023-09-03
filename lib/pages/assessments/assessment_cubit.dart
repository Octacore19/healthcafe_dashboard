import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/domain/models/assessment.dart';
import 'package:healthcafe_dashboard/domain/repos/assessment.dart';
import 'package:healthcafe_dashboard/domain/requests/assessment.dart';

part 'assessment_state.dart';

class AssessmentCubit extends Cubit<AssessmentState> {
  AssessmentCubit({
    required AssessmentRepo assessmentRepo,
    bool manage = false,
    String? id,
  })  : _repo = assessmentRepo,
        _id = id,
        super(InitialState()) {
    _subscription = _repo.assessments.listen((assessments) {
      emit(LoadedState(assessments));
    });
    _repo.fetchAssessmentList();
    if (manage) {
      final assessment = _repo.fetchAssessment(id);
      _nameController = TextEditingController(text: assessment?.name);
      _descController = TextEditingController(text: assessment?.description);
      final questions = assessment?.questions;
      if (questions != null) {
        _questionControllers = List.generate(
          questions.length,
          (index) => TextEditingController(
            text: questions[index],
          ),
        );
      } else {
        _questionControllers = List.generate(
          1,
          (index) => TextEditingController(),
        );
      }
    }
  }

  final AssessmentRepo _repo;
  final String? _id;

  bool get _isEdit => _id != null;

  TextEditingController? _nameController;

  TextEditingController? _descController;

  List<TextEditingController>? _questionControllers;

  StreamSubscription<List<Assessment>>? _subscription;

  TextEditingController? get nameController => _nameController;

  TextEditingController? get descController => _descController;

  List<TextEditingController>? get questionControllers => _questionControllers;

  bool get valueChanged {
    final assessment = _repo.fetchAssessment(_id);
    final name = _nameController?.text.trim();
    final desc = _descController?.text.trim();
    final questions = _questionControllers?.map((e) => e.text.trim()).toList();
    final isNotSame = questions?.map(
        (q) => assessment?.questions.firstWhereOrNull((e) => q != e) != null);
    final isSame = isNotSame?.firstWhereOrNull((element) => element);
    return assessment?.name != name ||
        assessment?.description != desc ||
        isSame != null;
  }

  void addNewQuestion() {
    _questionControllers?.add(TextEditingController());
  }

  void submitAssessment() async {
    try {
      emit(LoadingState(state.assessments));
      List<String> questions =
          _questionControllers?.map((e) => e.text.trim()).toList() ?? [];
      final name = _nameController?.text.trim();
      final desc = _descController?.text.trim();
      final request = AssessmentRequest(
        name: name ?? '',
        questions: questions,
        description: desc?.isEmpty == true ? null : desc,
      );
      if (_isEdit) {
        await _repo.updateAssessment(_id, request);
      } else {
        await _repo.addNewAssessment(request);
      }
      emit(SuccessState(state.assessments));
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(ErrorState(state.assessments, 'An error occurred!'));
    }
  }

  void delete(String? id) async {
    emit(LoadingState(state.assessments));
    try {
      await _repo.deleteAssessment(id);
      emit(SuccessState(state.assessments));
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(ErrorState(state.assessments, 'An error occurred!'));
    }
  }

  @override
  Future<void> close() {
    _nameController?.dispose();
    _descController?.dispose();
    _questionControllers?.forEach((element) {
      element.dispose();
    });
    _subscription?.cancel();
    return super.close();
  }
}
