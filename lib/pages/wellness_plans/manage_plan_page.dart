import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/gen/assets.gen.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/gen/fonts.gen.dart';
import 'package:healthcafe_dashboard/pages/wellness_plans/wellness_plan_cubit.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/utils/currency_text_formatter.dart';
import 'package:healthcafe_dashboard/utils/widget_utils.dart';
import 'package:healthcafe_dashboard/widgets/dialog_prompt.dart';
import 'package:healthcafe_dashboard/widgets/labelled_textfield.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';
import 'package:healthcafe_dashboard/widgets/title_subtitle_view.dart';

class ManagePlanPage extends AppPage {
  const ManagePlanPage({required super.state});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WellnessPlanCubit(
        planRepo: RepositoryProvider.of(context),
        id: state.pathParameters['id'],
        manage: true,
      ),
      child: _Screen(
        isEdit: state.pathParameters['id'] != null,
        key: super.key,
      ),
    );
  }
}

class _Screen extends StatefulWidget {
  const _Screen({required this.isEdit, super.key});

  final bool isEdit;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Screen> {
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
                    buildNamePriceFields(context),
                    buildDescField(context),
                    buildSubmitBtn(context, constraint),
                  ],
                );
              },
            ),
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
          title: widget.isEdit ? 'Edit plan' : 'Add new plan',
          subtitle: widget.isEdit
              ? 'Edit plan details here'
              : 'Fill plan details here',
          titleSize: 20,
          subtitleSize: 16,
        )
      ],
    );
  }

  Widget buildNamePriceFields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30).h,
      child: Row(
        children: [
          Expanded(
            child: LabelledTextField(
              label: 'Plan name',
              controller: _cubit.nameController,
              onSubmit: (_) => onSubmitPlan(),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: LabelledTextField(
              label: 'Price',
              controller: _cubit.priceController,
              formatters: [DecimalFormatter()],
              inputType: TextInputType.number,
              onSubmit: (_) => onSubmitPlan(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDescField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30).h,
          child: LabelledTextField(
            controller: _cubit.descController,
            label: 'Plan breakdown',
            textCapitalization: TextCapitalization.words,
            onSubmit: (_) => onSubmitPlan(),
            multiline: true,
            minLine: 4,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4).h,
          child: Text(
            'Separate each test with a comma.',
            style: TextStyle(
              fontFamily: FontFamily.inter,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: ColorName.grey500,
            ),
          ),
        )
      ],
    );
  }

  Widget buildSubmitBtn(BuildContext context, BoxConstraints constraint) {
    return Container(
      alignment: Alignment.centerRight,
      child: Textbutton(
        label: 'Submit',
        bgColor: ColorName.primary500,
        fgColor: Colors.white,
        minimumSize: Size(constraint.maxWidth * 0.2, 48),
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16).r,
        onTap: onSubmitPlan,
      ),
    );
  }

  void onSubmitPlan() {
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
        message: 'Name of plan cannot be empty',
      );
      return;
    } else if (_cubit.priceController?.text.isEmpty == true) {
      showWarningSnackBar(
        context: context,
        message: 'Price of plan cannot be empty',
      );
      return;
    }
    DialogPrompt.show(
      context: context,
      icon: widget.isEdit ? Assets.img.warningIcon : Assets.img.successIcon,
      title: widget.isEdit ? 'Save changes' : 'Add new test',
      subtitle: widget.isEdit
          ? 'Are you sure you want to save these changes?'
          : 'Are you sure you want to add this plan?',
      rightBtnTxt: widget.isEdit ? 'Save' : 'Confirm',
      leftBtnTxt: 'Cancel',
      rightBtnBg: widget.isEdit ? ColorName.warning500 : ColorName.primary500,
      onLeftClicked: context.pop,
      onRightClicked: _cubit.submit,
    );
  }
}
