import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/res/images.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';

class DashboardPage extends AppPage {
  const DashboardPage({required super.args});

  @override
  Widget build(BuildContext context) {
    return const DashboardScreen();
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
      backgroundColor: AppColors.grey50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppSvgs.notificationIcon,
            ),
          ),
          SizedBox(width: 24.w),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildTitleSubtitle(context),
              SizedBox(height: 20.h),
              buildMetric(context),
              buildChart(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitleSubtitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Welcome',
          style: TextStyle(
            fontSize: 36.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Track, manage and forecast your customers and orders.',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }

  Widget buildMetric(BuildContext context) {
    return Row(
      children: [
        Expanded(child: buildMetricItem(context, 'Users', '2000')),
        SizedBox(width: 16.w),
        Expanded(child: buildMetricItem(context, 'Total appointments', '2000')),
        SizedBox(width: 16.w),
        Expanded(
          child: buildMetricItem(
            context,
            'Pending appointments',
            '2000',
          ),
        ),
      ],
    );
  }

  Widget buildMetricItem(BuildContext context, String title, String count) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0).r,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppSvgs.dropdownIcon),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16).r,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      count,
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          size: 20.r,
                          color: AppColors.success500,
                        ),
                        Text(
                          '100%',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: AppColors.success500),
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
                    )
                  ],
                ),
                const Expanded(child: SizedBox())
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildChart(BuildContext context) {
    return Row(
      children: [
        Expanded(child: buildChartItem(context, 'Top test')),
        SizedBox(width: 16.w),
        Expanded(child: buildChartItem(context, 'Wellness plans')),
        SizedBox(width: 16.w),
        Expanded(child: buildChartItem(context, 'HMO plans'))
      ],
    );
  }

  Widget buildChartItem(BuildContext context, String title) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16).r,
        child: Column(
          children: [
            Text(title),
            SizedBox(height: 16.h),
            Row(
              children: [
                SizedBox(
                  height: 0.2.sh,
                  width: 0.2.sw,
                  child: PieChart(
                    PieChartData(),
                  ),
                ),
                Expanded(child: Column())
              ],
            ),
          ],
        ),
      ),
    );
  }
}