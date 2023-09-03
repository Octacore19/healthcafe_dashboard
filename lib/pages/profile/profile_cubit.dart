import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/auth.dart';
import 'package:healthcafe_dashboard/domain/requests/profile.dart';
import 'package:healthcafe_dashboard/pages/login/login_cubit.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const InitialState()) {
    _userSub = _authRepo.authUser.listen((user) {
      emit(UpdatedState(user: user));
    });

    final user = _authRepo.currentUser;
    _firstNameCtr = TextEditingController(text: user?.firstName);
    _lastNameCtr = TextEditingController(text: user?.lastName);
    _phoneCtr = TextEditingController(text: user?.phone);
    _pwdCtr = TextEditingController();
    _newPwdCtr = TextEditingController();
    _cnfNewPwdCtr = TextEditingController();
  }

  final AuthRepo _authRepo;

  StreamSubscription<AuthUser?>? _userSub;

  TextEditingController? _firstNameCtr;

  TextEditingController? _lastNameCtr;

  // TextEditingController? _emailCtr;

  TextEditingController? _phoneCtr;

  TextEditingController? _pwdCtr;

  TextEditingController? _newPwdCtr;

  TextEditingController? _cnfNewPwdCtr;

  TextEditingController? get firstNameCtr => _firstNameCtr;

  TextEditingController? get lastNameCtr => _lastNameCtr;

  // TextEditingController? get emailCtr => _emailCtr;

  TextEditingController? get phoneCtr => _phoneCtr;

  TextEditingController? get pwdCtr => _pwdCtr;

  TextEditingController? get newPwdCtr => _newPwdCtr;

  TextEditingController? get cnfNewPwdCtr => _cnfNewPwdCtr;

  bool get profileValueChanged {
    final plan = _authRepo.currentUser;
    final firstName = _firstNameCtr?.text.trim();
    final lastName = _lastNameCtr?.text.trim();
    final phone = _phoneCtr?.text.trim();
    return plan?.firstName != firstName ||
        plan?.lastName != lastName ||
        plan?.phone != phone;
  }

  void updateProfile() async {
    try {
      emit(LoadingState(user: state.user));
      final firstName = _firstNameCtr?.text.trim();
      final lastName = _lastNameCtr?.text.trim();
      final phone = _phoneCtr?.text.trim();
      final request = ProfileRequest(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phone?.isEmpty == true ? null : phone,
      );
      await _authRepo.updateAdminProfile(request);
      emit(SuccessState(user: state.user, type: ProfileChangeType.profile));
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(ErrorState(user: state.user, message: e.toString()));
    }
  }

  void updatePassword() async {}

  @override
  Future<void> close() {
    _firstNameCtr?.dispose();
    _lastNameCtr?.dispose();
    // _emailCtr?.dispose();
    _phoneCtr?.dispose();
    _pwdCtr?.dispose();
    _newPwdCtr?.dispose();
    _cnfNewPwdCtr?.dispose();
    _userSub?.cancel();
    return super.close();
  }
}
