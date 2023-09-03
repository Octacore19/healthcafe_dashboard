import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/gen/fonts.gen.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/widgets/labelled_textfield.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';

class ForgotPasswordPage extends AppPage {
  const ForgotPasswordPage({required super.state, super.key});

  @override
  Widget build(BuildContext context) {
    return const _Screen();
  }
}

class _Screen extends StatefulWidget {
  const _Screen({Key? key}) : super(key: key);

  @override
  State<_Screen> createState() => _State();
}

class _State extends State<_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (p0, p1) => SizedBox(
          width: p1.maxWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Forgot password',
                style: TextStyle(
                  fontFamily: FontFamily.poppins,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorName.grey900,
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: p1.maxWidth * 0.5,
                child: Text(
                  'A password reset link will be sent to your email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontFamily.poppins,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorName.grey600,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              LabelledTextField(
                width: p1.maxWidth * 0.5,
                label: 'Email',
                hint: 'john.doe@domain.com',
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.h),
              Textbutton(
                label: 'Submit',
                width: p1.maxWidth * 0.5,
                bgColor: ColorName.primary500,
                fgColor: Colors.white,
                minimumSize: Size(p1.maxWidth * 0.5, 48),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10).r,
                onTap: () => context.go('/login'),
              ),
              SizedBox(height: 20.h),
              Container(
                width: p1.maxWidth * 0.5,
                alignment: Alignment.centerLeft,
                child: Textbutton(
                  width: p1.maxWidth * 0.5,
                  padding: EdgeInsets.zero,
                  density: VisualDensity.compact,
                  onTap: () => context.go('/login'),
                  child: Text.rich(
                    TextSpan(
                      text: 'Remember password? ',
                      style: TextStyle(
                        fontFamily: FontFamily.poppins,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorName.primary500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}