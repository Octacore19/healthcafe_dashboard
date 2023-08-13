import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/widgets/pagination_footer.dart';
import 'package:healthcafe_dashboard/widgets/search_filter_view.dart';
import 'package:healthcafe_dashboard/widgets/title_subtitle_view.dart';
import 'package:healthcafe_dashboard/utils/data_table.dart' as table;

class AppointmentsPage extends AppPage {
  const AppointmentsPage({
    required super.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AppointmentsScreen();
  }
}

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 40).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleSubtitleView(
              title: 'Appointments',
              subtitle: 'Manage and track appointments',
              titleSize: 20,
              subtitleSize: 16,
            ),
            SizedBox(height: 30.h),
            buildContentCard(context),
          ],
        ),
      ),
    );
  }

  Widget buildContentCard(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16).r),
      child: Padding(
        padding: const EdgeInsets.all(30).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchVilterView(
              showFilter: true,
              onFromTapped: () {},
              onToTapped: () {},
            ),
            buildAppointmentTable(context),
            Padding(
              padding: const EdgeInsets.only(top: 30).h,
              child: const PaginationFooter(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAppointmentTable(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30).h,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.gray200),
            borderRadius: BorderRadius.circular(16),
          ),
          child: table.DataTable(
            columnSpacing: 4,
            showCheckboxColumn: false,
            headingRowColor: MaterialStateProperty.resolveWith(
              (states) => AppColors.grey50,
            ),
            border: const TableBorder(
              horizontalInside: BorderSide(color: AppColors.gray200),
            ),
            columns: const [
              table.DataColumn(label: Text('Date')),
              table.DataColumn(label: Text('Username')),
              table.DataColumn(label: Text('Appointment ID')),
              table.DataColumn(label: Text('Appointment type')),
              table.DataColumn(label: Text('Address')),
              table.DataColumn(label: Text('Phone number')),
              table.DataColumn(label: Text("Status")),
            ],
            rows: List.generate(
              10,
              (index) => table.DataRow.byIndex(
                index: index,
                onSelectChanged: (value) {
                  GoRouter.of(context).go('/appointments/detail/${000000}');
                },
                cells: const [
                  table.DataCell(Text('11-04-2022')),
                  table.DataCell(Text('11:00 am')),
                  table.DataCell(Text('VAC-826778785')),
                  table.DataCell(Text('Olivia Rhye')),
                  table.DataCell(Text('Olivia Rhye')),
                  table.DataCell(Text('Olivia Rhye')),
                  table.DataCell(
                    Text('Completed'),
                    showSuffix: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
