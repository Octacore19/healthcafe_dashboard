import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/domain/models/appointment.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/pages/appointments/appointment_cubit.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/utils/date_formatter.dart';
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
    return BlocProvider(
      create: (context) => AppointmentCubit(
        appointmentRepo: RepositoryProvider.of(context),
      ),
      child: const _Screen(),
    );
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
    return BlocBuilder<AppointmentCubit, AppointmentState>(
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
                SearchFilterView(
                  showFilter: true,
                  onFromTapped: () {},
                  onToTapped: () {},
                ),
                buildAppointmentTable(context, state.appointments),
                Padding(
                  padding: const EdgeInsets.only(top: 30).h,
                  child: const PaginationFooter(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildAppointmentTable(
    BuildContext context,
    List<Appointment> appointments,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 30).h,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(color: ColorName.gray200),
            borderRadius: BorderRadius.circular(16),
          ),
          child: table.DataTable(
            columnSpacing: 4,
            showCheckboxColumn: false,
            headingRowColor: MaterialStateProperty.resolveWith(
              (states) => ColorName.grey50,
            ),
            border: const TableBorder(
              horizontalInside: BorderSide(color: ColorName.gray200),
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
            rows: appointments.mapIndexed((index, appointment) {
              final appointmentDate = appointment.date.formatDate;
              return table.DataRow.byIndex(
                index: index,
                onSelectChanged: (value) {
                  GoRouter.of(context).go('/appointments/detail/${0}');
                },
                cells: [
                  table.DataCell(Text(appointmentDate)),
                  table.DataCell(Text(appointment.user?.name ?? 'Nil')),
                  table.DataCell(Text(appointment.id)),
                  table.DataCell(Text('Olivia Rhye')),
                  table.DataCell(Text('Olivia Rhye')),
                  table.DataCell(Text('Olivia Rhye')),
                  table.DataCell(
                    Text('Completed'),
                    showSuffix: true,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
