import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/bloc/auth_bloc.dart';
import 'package:healthcafe_dashboard/bloc/dashboard_cubit.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';
import 'package:healthcafe_dashboard/widgets/title_subtitle_view.dart';
import 'package:intl/intl.dart';

class DashboardPage extends AppPage {
  const DashboardPage({
    required super.args,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _State();
}

class _State extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 40).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildTitleSubtitle(context),
            SizedBox(height: 30.h),
            buildMetric(context),
            SizedBox(height: 30.h),
            buildActivitiesChart(context),
            SizedBox(height: 30.h),
            buildAppointmentWellnessCards(context),
          ],
        ),
      ),
    );
  }

  Widget buildTitleSubtitle(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final name = state.user?.name ?? '';
        if (state is! AuthenticatedState) return const SizedBox();
        return TitleSubtitleView(
          title: 'Welcome $name',
          subtitle: 'Track, manage and forecast your customers and orders.',
        );
      },
    );
  }

  Widget buildMetric(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: buildMetricItem(
            context: context,
            title: 'Users',
            count: 2000,
            percent: 100,
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: buildMetricItem(
            context: context,
            title: 'Total appointments',
            count: 2000,
            percent: 30,
            isSuccess: false,
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: buildMetricItem(
            context: context,
            title: 'Pending appointments',
            count: 2000,
            percent: 50,
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: buildMetricItem(
            context: context,
            title: 'Total Sales',
            count: 2000,
            percent: 59.5,
            isSuccess: false,
          ),
        ),
      ],
    );
  }

  Widget buildMetricItem({
    required BuildContext context,
    required String title,
    required int count,
    required double percent,
    bool isSuccess = true,
  }) {
    final format = NumberFormat('#,##0');
    final icon = isSuccess ? Icons.arrow_upward : Icons.arrow_downward;
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              format.format(count),
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Icon(
                  icon,
                  size: 20.r,
                  color: isSuccess ? AppColors.success500 : AppColors.danger500,
                ),
                Text(
                  '$percent%',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color:
                        isSuccess ? AppColors.success500 : AppColors.danger500,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  'vs last month',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActivitiesChart(BuildContext context) {
    return Column(
      children: [
        buildCardHeader(context, 'Activities'),
        buildActivitiesChartBody(context)
      ],
    );
  }

  Widget buildActivitiesChartBody(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0.5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: SizedBox(
          height: 300.h,
          width: double.maxFinite,
        ),
      ),
    );
  }

  Widget buildAppointmentWellnessCards(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width * 0.55,
          child: buildAppointmentCard(context),
        ),
        SizedBox(width: 24.w),
        Flexible(child: buildWellnessCard(context)),
      ],
    );
  }

  Widget buildAppointmentCard(BuildContext context) {
    return Column(
      children: [
        buildCardHeader(context, 'Upcoming Appointments'),
        buildAppointmentContent(
            context, List.generate(5, (index) => 'Appointment ${index + 1}')),
        buildAppointmentFooter(context),
      ],
    );
  }

  Widget buildWellnessCard(BuildContext context) {
    return Column(
      children: [
        buildCardHeader(context, 'Top wellness plans'),
        buildWellnessChart(context),
      ],
    );
  }

  Widget buildWellnessChart(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      ),
    );
  }

  Widget buildAppointmentContent(
    BuildContext context,
    List<String> appointments,
  ) {
    Widget buildItem(
      String title, {
      Color color = AppColors.grey50,
      FontWeight weight = FontWeight.w600,
      double size = 14,
    }) {
      return Text(
        title,
        style: TextStyle(
          fontSize: size.sp,
          fontWeight: weight,
          color: color,
        ),
      );
    }

    List<Widget> children = [];
    Widget header = Card(
      elevation: 0.5,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: Row(
          children: [
            Expanded(child: buildItem('Fullname')),
            Expanded(child: buildItem('Date')),
            Expanded(child: buildItem('Wellness Plan')),
            Expanded(child: buildItem('Phone Number')),
            Expanded(child: buildItem('Address')),
          ],
        ),
      ),
    );
    children.add(header);

    for (var appointment in appointments) {
      Widget child = Card(
        elevation: 0.5,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Row(
            children: [
              Expanded(
                child: buildItem(
                  'Fullname',
                  weight: FontWeight.w500,
                  color: AppColors.grey700,
                ),
              ),
              Expanded(child: buildItem('Date', weight: FontWeight.w400)),
              Expanded(child: buildItem(appointment, weight: FontWeight.w400)),
              Expanded(
                child: buildItem(
                  'Phone Number',
                  weight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: buildItem(
                        'Address',
                        weight: FontWeight.w400,
                      ),
                    ),
                    Textbutton(
                      onTap: () {},
                      label: 'View',
                      fgColor: AppColors.primary500,
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      children.add(child);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget buildAppointmentFooter(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Textbutton(
              onTap: () {},
              fgColor: AppColors.grey50,
              child: Row(
                children: [
                  Icon(Icons.arrow_back, size: 16.r),
                  SizedBox(width: 6.w),
                  Text(
                    'Prev',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  splashRadius: 24.r,
                  visualDensity: VisualDensity.compact,
                  icon: Text('1'),
                ),
                IconButton(
                  onPressed: () {},
                  splashRadius: 24.r,
                  visualDensity: VisualDensity.compact,
                  icon: Text('2'),
                ),
                IconButton(
                  onPressed: () {},
                  splashRadius: 24.r,
                  visualDensity: VisualDensity.compact,
                  icon: Text('5'),
                ),
                IconButton(
                  onPressed: () {},
                  splashRadius: 24.r,
                  visualDensity: VisualDensity.compact,
                  icon: Text('6'),
                ),
              ],
            ),
            Textbutton(
              onTap: () {},
              fgColor: AppColors.grey50,
              child: Row(
                children: [
                  Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Icon(Icons.arrow_forward, size: 16.r),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardHeader(BuildContext context, String title) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: AppColors.grey700,
          ),
        ),
      ),
    );
  }
}
