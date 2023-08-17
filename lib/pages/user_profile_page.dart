import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/bloc/users_cubit.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/res/images.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/widgets/pagination_footer.dart';
import 'package:healthcafe_dashboard/widgets/search_filter_view.dart';
import 'package:healthcafe_dashboard/widgets/title_subtitle_view.dart';
import 'package:healthcafe_dashboard/utils/data_table.dart' as table;
import 'package:intl/intl.dart';

class UserProfilePage extends AppPage {
  const UserProfilePage({required super.state});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit(
        userRepo: RepositoryProvider.of(context),
        id: state.pathParameters['id'],
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
                buildProfileHeader(context, state.selected),
                buildProfileInfo(context, state.selected),
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

  Widget buildProfileHeader(BuildContext context, AuthUser? user) {
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
                user?.name ?? '',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                  color: AppColors.grey900,
                ),
              ),
              Text(
                user?.email ?? '',
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
              minimumSize: Size(124.w, 48.h),
            ),
            child: const Text('Deactivate'),
          ),
        ),
      ],
    );
  }

  Widget buildProfileInfo(BuildContext context, AuthUser? user) {
    final formatter = DateFormat('dd-MM-yyyy');
    final creationDate =
        user?.dateCreated != null ? formatter.format(user!.dateCreated!) : 'Nil';
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
                      user?.name ?? 'Nil',
                    ),
                    buildDataTab(
                      AppSvgs.sms,
                      'Email address',
                      user?.email ?? 'Nil',
                    ),
                    buildDataTab(
                      AppSvgs.call,
                      'Phone number',
                      user?.phone ?? 'Nil',
                    ),
                    buildDataTab(
                      AppSvgs.cardTick,
                      'Total plans',
                      'Nil',
                    ),
                    buildDataTab(
                      AppSvgs.calendarTick,
                      'Date joined',
                      creationDate,
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
                      'Nil',
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
    TextStyle style = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.grey900,
      overflow: TextOverflow.fade,
    );
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: table.DataTable(
          columnSpacing: 4,
          showCheckboxColumn: false,
          clipBehavior: Clip.hardEdge,
          headingRowColor: MaterialStateProperty.resolveWith(
            (states) => AppColors.grey50,
          ),
          border: const TableBorder(
            horizontalInside: BorderSide(color: AppColors.gray200),
          ),
          headingTextStyle: style,
          columns: const [
            table.DataColumn(label: Text('Date')),
            table.DataColumn(label: Text('Time')),
            table.DataColumn(label: Text('Appointment ID')),
            table.DataColumn(label: Text('Appointment name')),
            table.DataColumn(label: Text('Address')),
            table.DataColumn(label: Text("Doctor's report")),
            table.DataColumn(label: Text("Status")),
          ],
          rows: List.generate(
            10,
            (index) {
              style = style.copyWith(color: AppColors.grey500);
              return table.DataRow.byIndex(
                index: index,
                cells: [
                  table.DataCell(Text('11-04-2022', style: style)),
                  table.DataCell(Text('11:00 am', style: style)),
                  table.DataCell(Text('VAC-826778785', style: style)),
                  table.DataCell(Text('Olivia Rhye', style: style)),
                  table.DataCell(Text('Olivia Rhye', style: style)),
                  table.DataCell(Text('Olivia Rhye', style: style)),
                  table.DataCell(
                    Text('Completed', style: style),
                    showSuffix: true,
                  ),
                ],
              );
            },
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
