import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/res/images.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/widgets/pagination_footer.dart';
import 'package:healthcafe_dashboard/widgets/search_filter_view.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';
import 'package:healthcafe_dashboard/widgets/title_subtitle_view.dart';
import 'package:healthcafe_dashboard/utils/data_table.dart' as table;

class WellnessPlansPage extends AppPage {
  const WellnessPlansPage({
    required super.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const WellnessPlanScreen();
  }
}

class WellnessPlanScreen extends StatefulWidget {
  const WellnessPlanScreen({super.key});

  @override
  State<WellnessPlanScreen> createState() => _State();
}

class _State extends State<WellnessPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 40).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitleSubtitleView(
                  title: 'Wellness plans',
                  subtitle: 'Manage wellness plans here',
                  titleSize: 20,
                  subtitleSize: 16,
                ),
                Textbutton(
                  onTap: () {},
                  label: 'Add new plan',
                  bgColor: AppColors.primary500,
                  fgColor: Colors.white,
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 8).r,
                  minimumSize: Size(124.w, 48.h),
                )
              ],
            ),
            buildContent(context),
          ],
        ),
      ),
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
              SearchFilterView(
                showFilter: true,
                onFromTapped: () {},
                onToTapped: () {},
              ),
              buildWellnessTable(context),
              Padding(
                padding: const EdgeInsets.only(top: 30).h,
                child: const PaginationFooter(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWellnessTable(BuildContext context) {
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
              table.DataColumn(label: Text('Plan name')),
              table.DataColumn(label: Text('Plan ID')),
              table.DataColumn(label: Text('Price')),
              table.DataColumn(label: Text('Orders')),
              table.DataColumn(
                label: Text('Description'),
              ),
            ],
            rows: List.generate(
              10,
              (index) => table.DataRow.byIndex(
                index: index,
                cells: [
                  const table.DataCell(Text('11-04-2022')),
                  const table.DataCell(Text('11:00 am')),
                  const table.DataCell(Text('VAC-826778785')),
                  const table.DataCell(Text('Olivia Rhye')),
                  table.DataCell(
                    const Text('Olivia Rhye'),
                    showSuffix: true,
                    suffix: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(AppSvgs.trash),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(AppSvgs.edit),
                        ),
                      ],
                    ),
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
