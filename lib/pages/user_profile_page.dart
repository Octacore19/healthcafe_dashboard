import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/bloc/users_cubit.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/res/images.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/widgets/pagination_footer.dart';
import 'package:healthcafe_dashboard/widgets/search_filter_view.dart';
import 'package:healthcafe_dashboard/widgets/title_subtitle_view.dart';
import 'package:intl/intl.dart';

class UserProfilePage extends AppPage {
  const UserProfilePage({required super.state});

  @override
  Widget build(BuildContext context) {
    // final id = state.pathParameters['id'] ?? '';
    return BlocProvider(
      create: (context) => UsersCubit(
        userRepo: RepositoryProvider.of(context),
      ),
      child: const UserProfileScreen(),
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
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
                  foregroundColor: AppColors.grey900,
                ),
              ),
            ),
            const TitleSubtitleView(
              title: 'User Profile',
              subtitle: 'Manage your user information',
              titleSize: 20,
              subtitleSize: 16,
            ),
            SizedBox(height: 30.h),
            buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        return Card(
          elevation: 0.5,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16).r,
          ),
          child: Padding(
            padding: const EdgeInsets.all(30).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildProfileHeader(context),
                buildProfileInfo(context),
                buildWellnessAssessment(context),
                Padding(
                  padding: const EdgeInsets.only(top: 20).h,
                  child: Text(
                    'Appointments',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30).h,
                  child: SearchVilterView(
                    onFromTapped: () {},
                    onToTapped: () {},
                    showFilter: true,
                  ),
                ),
                buildAssessmentTable(context),
                const PaginationFooter()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildProfileHeader(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20).w,
          child: ClipOval(
            child: FadeInImage.assetNetwork(
              placeholder: AppImages.loading,
              image: 'https://www.google.com',
              imageErrorBuilder: (_, __, stack) => Image(
                image: const AssetImage(AppImages.profilePicture),
                height: 120.h,
                width: 120.w,
              ),
              height: 120.h,
              width: 120.w,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                  color: AppColors.grey900,
                ),
              ),
              Text(
                'Lorem ipsum ipsum',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: AppColors.grey500,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20).w,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.danger500,
            ),
            child: const Text('Deactivate'),
          ),
        ),
      ],
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

  Widget buildAssessmentTable(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: DataTable(
        showCheckboxColumn: false,
        headingRowColor:
            MaterialStateProperty.resolveWith((states) => AppColors.grey50),
        border: TableBorder(
          top: const BorderSide(color: AppColors.gray200),
          bottom: const BorderSide(color: AppColors.gray200),
          left: const BorderSide(color: AppColors.gray200),
          right: const BorderSide(color: AppColors.gray200),
          horizontalInside: const BorderSide(color: AppColors.gray200),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8).r,
            topRight: const Radius.circular(8).r,
            bottomLeft: const Radius.circular(8).r,
            bottomRight: const Radius.circular(8).r,
          ).r,
        ),
        columns: const [
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Time')),
          DataColumn(label: Text('Appointment ID')),
          DataColumn(label: Text('Appointment name')),
          DataColumn(label: Text('Address')),
          DataColumn(label: Text("Doctor's report")),
          DataColumn(label: Text("Status")),
        ],
        rows: List.generate(
          10,
          (index) => DataRow.byIndex(
            index: index,
            cells: const [
              DataCell(Text('11-04-2022')),
              DataCell(Text('11:00 am')),
              DataCell(Text('VAC-826778785')),
              DataCell(Text('Olivia Rhye')),
              DataCell(Text('Olivia Rhye')),
              DataCell(Text('Olivia Rhye')),
              DataCell(Text('Completed')),
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
                color: AppColors.primary25,
                value: 30,
                radius: 15,
                showTitle: false,
              ),
              PieChartSectionData(
                color: AppColors.primary500,
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
                color: AppColors.primary500,
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
                color: AppColors.grey50,
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
                    color: AppColors.grey400,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    color: AppColors.grey700,
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
