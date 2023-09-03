import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/gen/assets.gen.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/gen/fonts.gen.dart';
import 'package:healthcafe_dashboard/pages/profile/profile_cubit.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/utils/widget_utils.dart';
import 'package:healthcafe_dashboard/widgets/labelled_textfield.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';

class ProfilePage extends AppPage {
  const ProfilePage({required super.state, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        authRepo: RepositoryProvider.of(context),
      ),
      child: const _Screen(),
    );
  }
}

class _Screen extends StatefulWidget {
  const _Screen({Key? key}) : super(key: key);

  @override
  State<_Screen> createState() => _State();
}

class _State extends State<_Screen> {
  bool _hidePassword = true;
  bool _hideNewPwd = true;
  bool _hideCnfPwd = true;
  late final ProfileCubit _cubit;

  set hidePassword(bool value) {
    _hidePassword = value;
    setState(() {});
  }

  bool get hidePassword => _hidePassword;

  set hideNewPwd(bool value) {
    _hideNewPwd = value;
    setState(() {});
  }

  bool get hideNewPwd => _hideNewPwd;

  set hideCnfNewPwd(bool value) {
    _hideCnfPwd = value;
    setState(() {});
  }

  bool get hideCnfNewPwd => _hideCnfPwd;

  @override
  void initState() {
    _hideCnfPwd = true;
    _hideNewPwd = true;
    _hidePassword = true;
    _cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is SuccessState) {
            showSuccessSnackBar(
              context: context,
              message: state.type == ProfileChangeType.profile
                  ? 'Profile successfully changed'
                  : 'Password successfully changed',
            );
          }
          if (state is ErrorState) {
            showErrorSnackBar(
              context: context,
              message: state.message,
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Profile',
              style: TextStyle(
                fontFamily: FontFamily.inter,
                fontSize: 18.sp,
                color: ColorName.gray700,
                fontWeight: FontWeight.w700,
              ),
            ),
            buildProfile(context),
            buildPersonalInfoCard(context),
            buildPasswordCard(),
          ],
        ),
      ),
    );
  }

  Widget buildProfile(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) => Container(
        margin: const EdgeInsets.only(top: 24).h,
        padding: const EdgeInsets.all(24).r,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8).r,
            side: const BorderSide(color: ColorName.grey200),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildUserProfile(context, state.user),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                minimumSize: Size(0.1.sw, 48),
                foregroundColor: ColorName.grey500,
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16).w,
                side: const BorderSide(color: ColorName.grey400),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24).r,
                ),
              ),
              child: Row(
                children: [
                  const Text('Upload profile photo'),
                  Assets.img.edit2.svg(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildUserProfile(BuildContext context, AuthUser? user) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 30).w,
          child: ClipOval(
            child: FadeInImage.assetNetwork(
              placeholder: Assets.img.loading.path,
              image: 'https://www.google.com',
              imageErrorBuilder: (_, __, stack) => Image(
                image: Assets.img.profilePlaceholder.provider(),
                height: 96.h,
                width: 96.w,
              ),
              height: 96.h,
              width: 96.w,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              user?.name ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: ColorName.grey800,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8).h,
              child: Text(
                user?.email ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: ColorName.grey600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8).h,
              child: Text(
                '',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: ColorName.grey500,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildPersonalInfoCard(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          margin: const EdgeInsets.only(top: 24).h,
          padding: const EdgeInsets.fromLTRB(24, 24, 80, 24).r,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8).r,
              side: const BorderSide(color: ColorName.grey200),
            ),
          ),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              final loading = state is LoadingState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorName.grey800,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: LabelledTextField(
                          label: 'First name',
                          inputType: TextInputType.name,
                          controller: _cubit.firstNameCtr,
                          hint: 'John',
                        ),
                      ),
                      SizedBox(width: 24.w),
                      Expanded(
                        child: LabelledTextField(
                          label: 'Last name',
                          inputType: TextInputType.name,
                          controller: _cubit.lastNameCtr,
                          hint: 'Doe',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.w),
                  Row(
                    children: [
                      Expanded(
                        child: LabelledTextField(
                          label: 'Phone number',
                          inputType: TextInputType.phone,
                          controller: _cubit.phoneCtr,
                          hint: '0800 000 0000',
                        ),
                      ),
                      SizedBox(width: 24.w),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24).h,
                    child: Textbutton(
                      label: 'Submit',
                      inProgress: loading,
                      bgColor: ColorName.primary500,
                      fgColor: Colors.white,
                      minimumSize: Size(constraints.maxWidth * 0.2, 48),
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16).r,
                      onTap: () {
                        if (!_cubit.profileValueChanged) {
                          showWarningSnackBar(
                            context: context,
                            message: 'No changes made',
                          );
                          return;
                        }
                        _cubit.updateProfile();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget buildPasswordCard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          margin: const EdgeInsets.only(top: 24).h,
          padding: const EdgeInsets.fromLTRB(24, 24, 80, 24).r,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8).r,
              side: const BorderSide(color: ColorName.grey200),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorName.grey800,
                ),
              ),
              SizedBox(height: 20.h),
              LabelledTextField(
                width: constraints.maxWidth * 0.4,
                label: 'Current password',
                inputType: TextInputType.visiblePassword,
                controller: _cubit.pwdCtr,
                hint: '*********',
                obscureText: hidePassword,
                showSuffix: true,
                toggleVisibility: (p0) => hidePassword = p0,
                autofill: const [AutofillHints.password],
              ),
              SizedBox(height: 10.h),
              LabelledTextField(
                width: constraints.maxWidth * 0.4,
                label: 'New password',
                inputType: TextInputType.visiblePassword,
                controller: _cubit.newPwdCtr,
                hint: '*********',
                obscureText: hideNewPwd,
                showSuffix: true,
                toggleVisibility: (p0) => hideNewPwd = p0,
                autofill: const [AutofillHints.password],
              ),
              SizedBox(height: 10.h),
              LabelledTextField(
                width: constraints.maxWidth * 0.4,
                label: 'Confirm new Password',
                inputType: TextInputType.visiblePassword,
                controller: _cubit.cnfNewPwdCtr,
                hint: '*********',
                obscureText: hideCnfNewPwd,
                showSuffix: true,
                toggleVisibility: (p0) => hideCnfNewPwd = p0,
                autofill: const [AutofillHints.password],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24).h,
                child: Textbutton(
                  label: 'Change password',
                  bgColor: ColorName.primary500,
                  fgColor: Colors.white,
                  minimumSize: Size(constraints.maxWidth * 0.2, 48),
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 16).r,
                  onTap: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
