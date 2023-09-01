import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/res/images.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';
import 'package:healthcafe_dashboard/widgets/title_subtitle_view.dart';

class UploadTestPage extends AppPage {
  const UploadTestPage({required super.state});

  @override
  Widget build(BuildContext context) {
    return const _Screen();
  }
}

class _Screen extends StatefulWidget {
  const _Screen({super.key});

  @override
  State<_Screen> createState() => _State();
}

class _State extends State<_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 40).r,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20).h,
                child: TextButton.icon(
                  onPressed: GoRouter.of(context).pop,
                  icon: Icon(Icons.arrow_back_ios, size: 16.r),
                  label: const Text('Back'),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: ColorName.grey900,
                  ),
                ),
              ),
              const TitleSubtitleView(
                title: 'Test Result',
                subtitle: 'Upload test information here.',
                titleSize: 20,
                subtitleSize: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30).h,
                child: Row(
                  children: [
                    Expanded(
                      child: buildInfoWidget(
                        'Full name',
                        'John Doe',
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: buildInfoWidget(
                        'Appointment type',
                        'Lorem ipsum',
                      ),
                    ),
                  ],
                ),
              ),
              buildRemarkField(context),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: buildInfoWidget(
                  'Medical report',
                  '',
                  center: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8).r,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorName.grey100,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(8).r,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorName.grey50,
                          ),
                          child: SvgPicture.asset(AppSvgs.uploadCloud),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: ColorName.primary500,
                              textStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: const Text('Click to upload'),
                          ),
                          Text(
                            'or drag and drop',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorName.gray500,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 24).w,
                child: Textbutton(
                  onTap: () {},
                  label: 'Submit',
                  bgColor: ColorName.primary500,
                  fgColor: Colors.white,
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 8).r,
                  minimumSize: Size(124.w, 48.h),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoWidget(
    String label,
    String text, {
    Widget? center,
    double? containerHeight,
  }) {
    Widget child = Text(
      text,
      style: TextStyle(
        color: ColorName.grey900,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
      ),
    );
    child = center ?? child;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: ColorName.gray700,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
          ),
        ),
        Container(
          width: double.maxFinite,
          height: containerHeight,
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 10).r,
          margin: const EdgeInsets.only(top: 8).h,
          decoration: BoxDecoration(
            border: Border.all(color: ColorName.gray300),
            color: ColorName.grey100,
            borderRadius: BorderRadius.circular(8).r,
          ),
          child: child,
        ),
      ],
    );
  }

  Widget buildRemarkField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Doctor\'s remark',
            style: TextStyle(
              color: ColorName.gray700,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8).h,
            child: TextField(
              minLines: 4,
              maxLines: null,
              decoration: InputDecoration(
                filled: true,
                fillColor: ColorName.grey100,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorName.gray300),
                  borderRadius: BorderRadius.circular(8).r,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorName.gray300),
                  borderRadius: BorderRadius.circular(8).r,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
