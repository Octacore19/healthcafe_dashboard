import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/domain/models/plan.dart';
import 'package:healthcafe_dashboard/domain/repos/vaccine.dart';
import 'package:healthcafe_dashboard/domain/requests/plan.dart';

part 'vaccines_state.dart';

class VaccinesCubit extends Cubit<VaccinesState> {
  VaccinesCubit({
    required VaccineRepo repo,
    bool manage = false,
    String? id,
  })  : _repo = repo,
        _id = id,
        super(const InitialState()) {
    _subscription = _repo.vaccines.listen((vaccines) {
      emit(UpdatedState(vaccines));
    });
    _repo.fetchAllVaccines();
    if (manage) {
      final plan = _repo.fetchVaccine(id);
      _nameController = TextEditingController(text: plan?.name);
      _priceController = TextEditingController(text: plan?.price);
      _descController = TextEditingController(text: plan?.description);
    }
  }

  final VaccineRepo _repo;
  final String? _id;

  bool get _isEdit => _id != null;

  TextEditingController? _nameController;
  TextEditingController? _priceController;
  TextEditingController? _descController;

  StreamSubscription? _subscription;

  TextEditingController? get nameController => _nameController;

  TextEditingController? get priceController => _priceController;

  TextEditingController? get descController => _descController;

  bool get valueChanged {
    final plan = _repo.fetchVaccine(_id);
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
      emit(LoadingState(state.vaccines));
      final request = PlanRequest(
        name: name,
        price: price,
        description: desc,
      );
      if (_isEdit) {
        await _repo.updateVaccine(_id, request);
      } else {
        await _repo.addNewVaccine(request);
      }
      emit(SuccessState(state.vaccines));
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(ErrorState(state.vaccines, 'An error occurred!'));
    }
  }

  void delete(String? id) async {
    emit(LoadingState(state.vaccines));
    try {
      await _repo.deleteVaccine(id);
      emit(SuccessState(state.vaccines));
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(ErrorState(state.vaccines, 'An error occurred!'));
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
