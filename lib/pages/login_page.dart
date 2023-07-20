import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/res/images.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/app_router.dart';
import 'package:healthcafe_dashboard/routing/router_cubit.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: const BoxDecoration(color: AppColors.primary600),
            child: Image(
              image: const AssetImage(AppImages.loginFrameImg),
              height: 1.sh,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign in',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16.h),
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
                label: 'Email',
              ),
              SizedBox(height: 16.h),
              LabelledTextField(
                label: 'Email',
              ),
              SizedBox(height: 20.h),
              Textbutton(
                label: 'Login',
                onTap: () {
                  final router = BlocProvider.of<RouterCubit>(context);
                  router.clearAndPush(AppRouter.home);
                },
              ),
            ],
          ),
        )
      ],
    ));
  }
}
