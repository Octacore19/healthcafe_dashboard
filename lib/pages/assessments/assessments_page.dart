import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/domain/models/assessment.dart';
import 'package:healthcafe_dashboard/gen/assets.gen.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/pages/assessments/assessment_cubit.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/utils/widget_utils.dart';
import 'package:healthcafe_dashboard/widgets/dialog_prompt.dart';
import 'package:healthcafe_dashboard/widgets/pagination_footer.dart';
import 'package:healthcafe_dashboard/widgets/search_filter_view.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';
import 'package:healthcafe_dashboard/widgets/title_subtitle_view.dart';
import 'package:healthcafe_dashboard/utils/data_table.dart' as table;

class AssessmentsPage extends AppPage {
  const AssessmentsPage({required super.state, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssessmentCubit(
        assessmentRepo: RepositoryProvider.of(context),
      ),
      child: _Screen(key: super.key),
    );
  }
}

class _Screen extends StatefulWidget {
  const _Screen({super.key});

  @override
  State<_Screen> createState() => _State();
}

class _State extends State<_Screen> {
  late final AssessmentCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AssessmentCubit, AssessmentState>(
        listener: (context, state) {
          if (state is SuccessState) {
            context.pop();
            showSuccessSnackBar(
              context: context,
              message: 'Assessment deleted successfully',
            );
          }
          if (state is ErrorState) {
            showErrorSnackBar(
              context: context,
              message: state.message,
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
                    title: 'Assessments',
                    subtitle: 'Manage assessments here',
                    titleSize: 20,
                    subtitleSize: 16,
                  ),
                  Textbutton(
                    onTap: () =>
                        GoRouter.of(context).go('/assessments/assessment'),
                    label: 'Add assessment',
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
    return BlocBuilder<AssessmentCubit, AssessmentState>(
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
                    onFromTapped: () {},
                    onToTapped: () {},
                    showDateSelector: false,
                  ),
                  buildWellnessTable(context, state.assessments),
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

  Widget buildWellnessTable(BuildContext context, List<Assessment> vaccines) {
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
              table.DataColumn(label: Text('Assessment name')),
              table.DataColumn(label: Text('Assessment ID')),
              table.DataColumn(label: Text('No of questions')),
              table.DataColumn(label: Text('Description')),
            ],
            rows: vaccines.mapIndexed(
              (index, e) {
                return table.DataRow.byIndex(
                  index: index,
                  cells: [
                    table.DataCell(Text(e.name)),
                    table.DataCell(Text(e.id)),
                    table.DataCell(Text(e.questions.length.toString())),
                    table.DataCell(
                      Text(e.description),
                      showSuffix: true,
                      suffix: Row(
                        children: [
                          IconButton(
                            onPressed: () => DialogPrompt.show(
                              context: context,
                              icon: Assets.img.errorIcon,
                              title: 'Delete vaccine',
                              subtitle:
                                  'Are you sure you want to delete this vaccine?',
                              rightBtnTxt: 'Delete',
                              leftBtnTxt: 'Cancel',
                              rightBtnBg: ColorName.danger500,
                              onLeftClicked: context.pop,
                              onRightClicked: () {
                                _cubit.delete(e.id);
                                context.pop();
                              },
                            ),
                            icon: Assets.img.trash.svg(),
                          ),
                          IconButton(
                            onPressed: () => GoRouter.of(context)
                                .go('/assessments/assessment/${e.id}'),
                            icon: Assets.img.edit.svg(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
