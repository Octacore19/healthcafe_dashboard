import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/gen/assets.gen.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/gen/fonts.gen.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';

class DialogPrompt extends StatelessWidget {
  static show({
    required BuildContext context,
    required SvgGenImage icon,
    required String title,
    required String subtitle,
    required String rightBtnTxt,
    required String leftBtnTxt,
    Color? rightBtnBg,
    VoidCallback? onRightClicked,
    VoidCallback? onLeftClicked,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => DialogPrompt(
        icon: icon,
        title: title,
        subtitle: subtitle,
        rightBtnTxt: rightBtnTxt,
        leftBtnTxt: leftBtnTxt,
        rightBtnBg: rightBtnBg,
        onLeftClicked: onLeftClicked,
        onRightClicked: onRightClicked,
      ),
    );
  }

  const DialogPrompt({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.leftBtnTxt,
    required this.rightBtnTxt,
    this.rightBtnBg,
    this.onLeftClicked,
    this.onRightClicked,
    Key? key,
  }) : super(key: key);

  final SvgGenImage icon;
  final String title;
  final String subtitle;
  final Color? rightBtnBg;
  final String rightBtnTxt;
  final String leftBtnTxt;
  final VoidCallback? onLeftClicked;
  final VoidCallback? onRightClicked;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12).r,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon.svg(),
            buildTitle(),
            buildSubtitle(),
            buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 20).h,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
          color: ColorName.grey900,
          fontFamily: FontFamily.inter,
        ),
      ),
    );
  }

  Widget buildSubtitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 8).h,
      child: Text(
        subtitle,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          color: ColorName.grey500,
          fontFamily: FontFamily.inter,
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32).h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Textbutton(
            label: leftBtnTxt,
            bgColor: Colors.white,
            fgColor: ColorName.gray700,
            minimumSize: Size(0.15.sw, 48),
            border: const BorderSide(color: ColorName.gray300),
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16).r,
            onTap: onLeftClicked,
          ),
          SizedBox(width: 12.w),
          Textbutton(
            label: rightBtnTxt,
            bgColor: rightBtnBg,
            fgColor: Colors.white,
            minimumSize: Size(0.15.sw, 48),
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16).r,
            onTap: onRightClicked,
          ),
        ],
      ),
    );
  }
}
