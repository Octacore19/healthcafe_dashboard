import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/domain/models/plan.dart';
import 'package:healthcafe_dashboard/gen/assets.gen.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/pages/wellness_plans/wellness_plan_cubit.dart';
import 'package:healthcafe_dashboard/res/images.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/utils/widget_utils.dart';
import 'package:healthcafe_dashboard/widgets/dialog_prompt.dart';
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
    return BlocProvider(
      create: (context) {
        return WellnessPlanCubit(planRepo: RepositoryProvider.of(context));
      },
      child: const WellnessPlanScreen(),
    );
  }
}

class WellnessPlanScreen extends StatefulWidget {
  const WellnessPlanScreen({super.key});

  @override
  State<WellnessPlanScreen> createState() => _State();
}

class _State extends State<WellnessPlanScreen> {
  late final WellnessPlanCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<WellnessPlanCubit, WellnessPlanState>(
        listener: (context, state) {
          if (state is SuccessState) {
            context.pop();
            showSuccessSnackBar(
              context: context,
              message: 'Plan added successfully',
            );
          }
          if (state is ErrorState) {
            showErrorSnackBar(
              context: context,
              message: state.message ?? 'An error occurred!',
            );
          }
        },
        child: SingleChildScrollView(
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
                    onTap: () => GoRouter.of(context).go('/wellness/plan'),
                    label: 'Add new plan',
                    bgColor: ColorName.primary500,
                    fgColor: Colors.white,
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 8).r,
                    minimumSize: Size(124.w, 48.h),
                  ),
                ],
              ),
              buildContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return BlocBuilder<WellnessPlanCubit, WellnessPlanState>(
      builder: (context, state) {
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
                  buildWellnessTable(context, state.plans),
                  Padding(
                    padding: const EdgeInsets.only(top: 30).h,
                    child: const PaginationFooter(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildWellnessTable(BuildContext context, List<Plan> plans) {
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
              table.DataColumn(label: Text('Plan name')),
              table.DataColumn(label: Text('Plan ID')),
              table.DataColumn(label: Text('Price')),
              table.DataColumn(label: Text('Orders')),
              table.DataColumn(label: Text('Description')),
            ],
            rows: plans
                .mapIndexed(
                  (index, e) => table.DataRow.byIndex(
                    index: index,
                    cells: [
                      table.DataCell(Text(e.name)),
                      table.DataCell(Text(e.id)),
                      table.DataCell(Text(e.price)),
                      table.DataCell(Text(e.totalOrders)),
                      table.DataCell(
                        Text(e.description),
                        showSuffix: true,
                        suffix: Row(
                          children: [
                            IconButton(
                              onPressed: () => DialogPrompt.show(
                                context: context,
                                icon: Assets.img.errorIcon,
                                title: 'Delete plan',
                                subtitle:
                                    'Are you sure you want to delete this plan?',
                                rightBtnTxt: 'Delete',
                                leftBtnTxt: 'Cancel',
                                rightBtnBg: ColorName.danger500,
                                onLeftClicked: context.pop,
                                onRightClicked: () => _cubit.delete(e.id),
                              ),
                              icon: SvgPicture.asset(AppSvgs.trash),
                            ),
                            IconButton(
                              onPressed: () => GoRouter.of(context)
                                  .go('/wellness/plan/${e.id}'),
                              icon: SvgPicture.asset(AppSvgs.edit),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
