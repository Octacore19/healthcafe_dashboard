import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/domain/models/wellness_plan.dart';
import 'package:healthcafe_dashboard/domain/repos/wellness_plan.dart';
import 'package:healthcafe_dashboard/domain/requests/wellness_plan.dart';

part 'wellness_plan_state.dart';

class WellnessPlanCubit extends Cubit<WellnessPlanState> {
  WellnessPlanCubit({
    required WellnessPlanRepo planRepo,
    bool manage = false,
    String? id,
  })  : _planRepo = planRepo,
        _planId = id,
        super(const InitialState()) {
    _subscription = _planRepo.plans.listen((plans) {
      emit(UpdatedState(plans));
    });
    _planRepo.fetchAllPlans();
    if (manage) {
      final plan = _planRepo.fetchPlan(id);
      _nameController = TextEditingController(text: plan?.name);
      _priceController = TextEditingController(text: plan?.price);
      _descController = TextEditingController(text: plan?.description);
    }
  }

  final WellnessPlanRepo _planRepo;
  final String? _planId;

  bool get _isEdit => _planId != null;

  TextEditingController? _nameController;
  TextEditingController? _priceController;
  TextEditingController? _descController;

  StreamSubscription? _subscription;

  TextEditingController? get nameController => _nameController;

  TextEditingController? get priceController => _priceController;

  TextEditingController? get descController => _descController;

  bool get valueChanged {
    final plan = _planRepo.fetchPlan(_planId);
    final name = _nameController?.text.trim();
    final price = _priceController?.text.trim();
    final desc = _descController?.text.trim();
    return plan?.name != name ||
        plan?.price != price ||
        plan?.description != desc;
  }

  bool get isEmpty {
    final name = _nameController?.text.trim();
    final price = _priceController?.text.trim();
    final desc = _descController?.text.trim();
    return name?.isEmpty == true ||
        price?.isEmpty == true ||
        desc?.isEmpty == true;
  }

  void submit() async {
    try {
      final name = _nameController?.text.trim();
      final price = _priceController?.text.trim();
      final desc = _descController?.text.trim();
      emit(LoadingState(state.plans));
      final request = WellnessPlanRequest(
        name: name,
        price: price,
        description: desc,
      );
      if (_isEdit) {
        await _planRepo.updatePlan(_planId, request);
      } else {
        await _planRepo.addNewPlan(request);
      }
      emit(SuccessState(state.plans));
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(ErrorState(state.plans, 'An error occurred!'));
    }
  }

  void delete(String? id) async {
    emit(LoadingState(state.plans));
    try {
      await _planRepo.deletePlan(id);
      emit(SuccessState(state.plans));
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(ErrorState(state.plans, 'An error occurred!'));
    }
  }

  @override
  Future<void> close() {
    _nameController?.dispose();
    _priceController?.dispose();
    _descController?.dispose();
    _subscription?.cancel();
    return super.close();
  }
}
