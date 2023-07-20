import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/auth_router_cubit.dart';
import 'package:healthcafe_dashboard/widgets/labelled_textfield.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';

class LoginPage extends AppPage {
  const LoginPage({required super.args, super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _State();
}

class _State extends State<LoginScreen> {
  bool _hidePassword = true;

  AuthRouterCubit? _router;

  set hidePassword(bool value) {
    _hidePassword = value;
    setState(() {});
  }

  bool get hidePassword => _hidePassword;

  @override
  void initState() {
    hidePassword = true;
    _router = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sign in',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.grey900,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Sign in to get started',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                LabelledTextField(
                  width: constraints.maxWidth * 0.5,
                  label: 'Email',
                  hint: 'john.doe@domain.com',
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                LabelledTextField(
                  width: constraints.maxWidth * 0.5,
                  label: 'Password',
                  hint: '*********',
                  obscureText: hidePassword,
                  showSuffix: true,
                  toggleVisibility: (p0) => hidePassword = p0,
                  inputType: TextInputType.visiblePassword,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: constraints.maxWidth * 0.5,
                  child: Textbutton(
                    label: 'Forgot password',
                    padding: EdgeInsets.zero,
                    density: VisualDensity.compact,
                    fgColor: AppColors.grey500,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                    onTap: () => _router?.onPageChanged(1),
                  ),
                ),
                SizedBox(height: 20.h),
                Textbutton(
                  label: 'Login',
                  width: constraints.maxWidth * 0.5,
                  bgColor: AppColors.primary500,
                  fgColor: Colors.white,
                  minimumSize: Size(constraints.maxWidth * 0.5, 48),
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10).r,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
