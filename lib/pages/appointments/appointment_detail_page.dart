import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/res/images.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';
import 'package:healthcafe_dashboard/widgets/title_subtitle_view.dart';
import 'package:intl/intl.dart';

class AppointmentDetailPage extends AppPage {
  const AppointmentDetailPage({required super.state});

  @override
  Widget build(BuildContext context) {
    return const AppointmentDetailScreen();
  }
}

class AppointmentDetailScreen extends StatefulWidget {
  const AppointmentDetailScreen({super.key});

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 40).r,
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
            buildHeader(context),
            buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Row(
      children: [
        const TitleSubtitleView(
          title: 'Appointment Information',
          subtitle: 'Manage your user information',
          titleSize: 20,
          subtitleSize: 16,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 8).w,
          child: Textbutton(
            onTap: () {},
            label: 'Download',
            border: const BorderSide(color: ColorName.grey300),
            borderRadius: BorderRadius.circular(8).r,
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 8).r,
            minimumSize: Size(124.w, 48.h),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8).w,
          child: Textbutton(
            onTap: () {
              GoRouter.maybeOf(context)?.go('/appointments/detail/${0}/result');
            },
            label: 'Upload Result',
            bgColor: ColorName.primary500,
            fgColor: Colors.white,
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 8).r,
            minimumSize: Size(124.w, 48.h),
          ),
        ),
      ],
    );
  }

  Widget buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30).h,
      child: Card(
        elevation: 0.5,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16).r,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppointmentInfo(context),
              buildProfileInfo(context),
              buildWellnessAssessment(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppointmentInfo(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16).r,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appointment Information',
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16).h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildDataTab(
                    AppSvgs.userTag,
                    'Appointment name',
                    'John Doe',
                  ),
                  buildDataTab(
                    AppSvgs.sms,
                    'Appointment ID',
                    'dummy@email.com',
                  ),
                  buildDataTab(
                    AppSvgs.call,
                    'Appointment date',
                    '0800000000',
                  ),
                  buildDataTab(
                    AppSvgs.cardTick,
                    'Appointment time',
                    'N30,000',
                  ),
                  buildDataTab(
                    AppSvgs.calendarTick,
                    'Amount',
                    '12-01-2023',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6).h,
              child: Row(
                children: [
                  buildDataTab(
                    AppSvgs.locationCross,
                    'Address',
                    '34, lorem street, Lekki',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20).h,
      child: Card(
        elevation: 0.5,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16).r,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Information',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16).h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildDataTab(
                      AppSvgs.userTag,
                      'Full name',
                      'John Doe',
                    ),
                    buildDataTab(
                      AppSvgs.sms,
                      'Email address',
                      'dummy@email.com',
                    ),
                    buildDataTab(
                      AppSvgs.call,
                      'Phone number',
                      '0800000000',
                    ),
                    buildDataTab(
                      AppSvgs.cardTick,
                      'Total plans',
                      'N30,000',
                    ),
                    buildDataTab(
                      AppSvgs.calendarTick,
                      'Date joined',
                      '12-01-2023',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6).h,
                child: Row(
                  children: [
                    buildDataTab(
                      AppSvgs.locationCross,
                      'Address',
                      '34, lorem street, Lekki',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWellnessAssessment(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20).h,
      child: Card(
        elevation: 0.5,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16).r,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wellness Assessment',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0).r,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20).w,
                      child: buildChart(context),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildDataTab(
                                AppSvgs.taskSquare,
                                'Health Assessment',
                                'Lorem Ipsum',
                              ),
                              buildDataTab(
                                AppSvgs.taskSquare,
                                'Nutritional Assessment',
                                'Lorem Ipsum',
                              ),
                              buildDataTab(
                                AppSvgs.taskSquare,
                                'Health Assessment',
                                'Lorem Ipsum',
                              ),
                              buildDataTab(
                                AppSvgs.taskSquare,
                                'Mental Health Assessment',
                                'Lorem Ipsum',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildDataTab(
                                AppSvgs.taskSquare,
                                'Health Assessment',
                                'Lorem Ipsum',
                              ),
                              buildDataTab(
                                AppSvgs.taskSquare,
                                'Nutritional Assessment',
                                'Lorem Ipsum',
                              ),
                              buildDataTab(
                                AppSvgs.taskSquare,
                                'Health Assessment',
                                'Lorem Ipsum',
                              ),
                              buildDataTab(
                                AppSvgs.taskSquare,
                                'Mental Health Assessment',
                                'Lorem Ipsum',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildDataTab(
                                AppSvgs.taskSquare,
                                'Health Assessment',
                                'Lorem Ipsum',
                              ),
                              buildDataTab(
                                AppSvgs.taskSquare,
                                'Nutritional Assessment',
                                'Lorem Ipsum',
                              ),
                              buildDataTab(
                                AppSvgs.taskSquare,
                                'Health Assessment',
                                'Lorem Ipsum',
                              ),
                              buildDataTab(
                                AppSvgs.taskSquare,
                                'Mental Health Assessment',
                                'Lorem Ipsum',
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChart(BuildContext context) {
    final df = NumberFormat('#,##0.00');
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.1,
      child: Stack(
        children: [
          PieChart(
            PieChartData(sections: [
              PieChartSectionData(
                color: ColorName.primary25,
                value: 30,
                radius: 15,
                showTitle: false,
              ),
              PieChartSectionData(
                color: ColorName.primary500,
                value: 70,
                radius: 20,
                showTitle: false,
              ),
            ], startDegreeOffset: -90, sectionsSpace: 2),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${df.format(70)}%',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: ColorName.primary500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDataTab(String icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10).h,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6).w,
            child: Container(
              padding: const EdgeInsets.all(8).r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorName.grey50,
              ),
              child: SvgPicture.asset(icon),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    fontFamily: 'Inter',
                    color: ColorName.grey400,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    color: ColorName.grey700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
