import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/gen/assets.gen.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 0.5.sw,
            child: DecoratedBox(
              decoration: const BoxDecoration(color: ColorName.primary600),
              child: Assets.img.loginFrameImg.image(
                height: 1.sh,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(
            width: 0.5.sw,
            child: child,
          ),
        ],
      ),
    );
  }
}
