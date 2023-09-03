import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/gen/assets.gen.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/pages/assessments/assessment_cubit.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/utils/widget_utils.dart';
import 'package:healthcafe_dashboard/widgets/dialog_prompt.dart';
import 'package:healthcafe_dashboard/widgets/labelled_textfield.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';
import 'package:healthcafe_dashboard/widgets/title_subtitle_view.dart';

class ManageAssessmentsPage extends AppPage {
  const ManageAssessmentsPage({required super.state});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssessmentCubit(
        assessmentRepo: RepositoryProvider.of(context),
        manage: true,
        id: state.pathParameters['id'],
      ),
      child: _Screen(
        key: super.key,
        isEdit: state.pathParameters['id'] != null,
      ),
    );
  }
}

class _Screen extends StatefulWidget {
  const _Screen({required this.isEdit, Key? key}) : super(key: key);

  final bool isEdit;

  @override
  State<_Screen> createState() => _ScreenState();
}

class _ScreenState extends State<_Screen> {
  late final AssessmentCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AssessmentCubit, AssessmentState>(
      listener: (context, state) {
        if (state is SuccessState) {
          context.pop();
          showSuccessSnackBar(
            context: context,
            message: widget.isEdit
                ? 'Entry edited successfully'
                : 'Assessment added successfully',
          );
          context.pop();
        }
        if (state is ErrorState) {
          showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 40).r,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: LayoutBuilder(
            builder: (context, constraint) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(context),
                  buildNameDescFields(context, constraint.maxWidth * 0.35),
                  buildQuestionFields(
                    _cubit.questionControllers,
                    context,
                    constraint.maxWidth * 0.35,
                  ),
                  buildSubmitBtn(context, constraint),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
        TitleSubtitleView(
          title: widget.isEdit ? 'Edit assessment' : 'Add new assessment',
          subtitle: widget.isEdit
              ? 'Edit assessment details here'
              : 'Fill assessment details here',
          titleSize: 20,
          subtitleSize: 16,
        )
      ],
    );
  }

  Widget buildNameDescFields(BuildContext context, double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 30).h,
      child: Row(
        children: [
          LabelledTextField(
            width: width,
            label: 'Assessment name',
            controller: _cubit.nameController,
            // onSubmit: (_) => onSubmitPlan(),
          ),
          SizedBox(width: 24.w),
          LabelledTextField(
            width: width,
            label: 'Assessment description',
            controller: _cubit.descController,
          ),
        ],
      ),
    );
  }

  Widget buildQuestionFields(
    List<TextEditingController?>? controllers,
    BuildContext context,
    double width,
  ) {
    List<Widget> children = [];
    if (controllers != null) {
      for (int i = 0; i < controllers.length; i++) {
        Widget child = LabelledTextField(
          width: width,
          label: 'Question ${i + 1}',
          controller: controllers[i],
        );
        children.add(child);
      }
    }
    return Padding(
      padding: const EdgeInsets.only(top: 24).h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 24.w,
            runSpacing: 24.h,
            children: children,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: TextButton.icon(
              onPressed: () {
                _cubit.addNewQuestion();
                setState(() {});
              },
              style: TextButton.styleFrom(
                backgroundColor: ColorName.primary25,
                foregroundColor: ColorName.primary500,
                minimumSize: Size(width * 0.35, 48.h),
              ),
              label: const Text('Add new question'),
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSubmitBtn(BuildContext context, BoxConstraints constraint) {
    return Padding(
      padding: const EdgeInsets.only(top: 24).h,
      child: Textbutton(
        label: widget.isEdit ? 'Update' : 'Submit',
        bgColor: ColorName.primary500,
        fgColor: Colors.white,
        minimumSize: Size(constraint.maxWidth * 0.2, 48),
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16).r,
        onTap: onSubmitAssessment,
      ),
    );
  }

  void onSubmitAssessment() {
    if (widget.isEdit && !_cubit.valueChanged) {
      showWarningSnackBar(
        context: context,
        message: 'No changes made',
      );
      return;
    }
    if (_cubit.nameController?.text.isEmpty == true) {
      showWarningSnackBar(
        context: context,
        message: 'Name of assessment cannot be empty',
      );
      return;
    }
    if (_cubit.questionControllers?.isNotEmpty == true) {
      final statuses = _cubit.questionControllers?.map((e) => e.text.isEmpty);
      final isEmpty = statuses?.firstWhereOrNull((element) => element);
      if (isEmpty == true) {
        showWarningSnackBar(
          context: context,
          message: 'You must add at least one question',
        );
        return;
      }
    }
    DialogPrompt.show(
      context: context,
      icon: widget.isEdit ? Assets.img.warningIcon : Assets.img.successIcon,
      title: widget.isEdit ? 'Save changes' : 'Add new assessment',
      subtitle: widget.isEdit
          ? 'Are you sure you want to save these changes?'
          : 'Are you sure you want to add this assessment?',
      rightBtnTxt: widget.isEdit ? 'Save' : 'Confirm',
      leftBtnTxt: 'Cancel',
      rightBtnBg: widget.isEdit ? ColorName.warning500 : ColorName.primary500,
      onLeftClicked: context.pop,
      onRightClicked: _cubit.submitAssessment,
    );
  }
}
