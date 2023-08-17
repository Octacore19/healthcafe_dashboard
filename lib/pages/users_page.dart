import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcafe_dashboard/bloc/users_cubit.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/widgets/pagination_footer.dart';
import 'package:healthcafe_dashboard/widgets/search_filter_view.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';
import 'package:healthcafe_dashboard/widgets/title_subtitle_view.dart';
import 'package:healthcafe_dashboard/utils/data_table.dart' as table;
import 'package:intl/intl.dart';

class UsersPage extends AppPage {
  const UsersPage({
    required super.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit(
        userRepo: RepositoryProvider.of(context),
      ),
      child: const UsersScreen(),
    );
  }
}

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  UsersCubit? _cubit;

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    _cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 40).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleSubtitleView(
              title: 'Manage Users',
              subtitle: 'Manage your customer information',
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16).r),
          child: Padding(
            padding: const EdgeInsets.all(30).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildPageTabs(state.users.length, 0, 0, 0),
                SizedBox(height: 30.h),
                SearchVilterView(
                  controller: _cubit?.searchController,
                  onFromTapped: () {},
                  onToTapped: () {},
                ),
                SizedBox(height: 30.h),
                buildListCard(context, state.users),
                const PaginationFooter(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPageTabs(int all, int active, int inactive, int newUsers) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.grey200,
          ),
        ),
      ),
      child: TabBar(
        controller: _controller,
        isScrollable: true,
        padding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.symmetric(horizontal: 20).w,
        indicatorColor: AppColors.primary500,
        labelColor: AppColors.primary500,
        unselectedLabelColor: AppColors.grey400,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        onTap: (index) {
          if (index == 1 && active != 0) {
            _controller?.index = index;
          } else if (index == 2 && inactive != 0) {
            _controller?.index = index;
          } else if (index == 3 && newUsers != 0) {
            _controller?.index = index;
          } else {
            _controller?.index = _controller?.previousIndex ?? index;
          }
        },
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        tabs: [
          Tab(text: 'All ($all)'),
          Tab(text: 'Active ($active)'),
          Tab(text: 'Inactive($inactive)'),
          Tab(text: 'New ($newUsers)'),
        ],
      ),
    );
  }

  Widget buildListCard(BuildContext context, List<AuthUser> users) {
    TextStyle style = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.grey800,
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
          headingTextStyle: style.copyWith(fontWeight: FontWeight.bold),
          columns: const [
            table.DataColumn(label: Text('Date Joined')),
            table.DataColumn(label: Text('Full name')),
            table.DataColumn(label: Text('Email')),
            table.DataColumn(label: Text('Phone number')),
            table.DataColumn(label: Text('Address')),
            table.DataColumn(label: Text('HMO')),
            table.DataColumn(label: Text("Status")),
          ],
          rows: users.mapIndexed((index, element) {
            final formatter = DateFormat('dd-MM-yyyy');
            final creationDate = element.dateCreated != null
                ? formatter.format(element.dateCreated!)
                : 'Nil';
            style = style.copyWith(color: AppColors.grey600);
            return table.DataRow.byIndex(
              index: index,
              cells: [
                table.DataCell(Text(creationDate, style: style)),
                table.DataCell(Text(element.name, style: style)),
                table.DataCell(Text(element.email, style: style)),
                table.DataCell(Text(element.phone, style: style)),
                table.DataCell(Text('Nil', style: style)),
                table.DataCell(Text('Nil', style: style)),
                table.DataCell(
                  Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16).r,
                          color: !element.disabled
                              ? AppColors.success50
                              : AppColors.warning50,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2).r,
                          child: Text(
                            !element.disabled ? 'active' : 'inactive',
                            style: style.copyWith(
                                color: !element.disabled
                                    ? AppColors.success700
                                    : AppColors.warning700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  showSuffix: true,
                  suffix: Textbutton(
                    onTap: () {
                      GoRouter.of(context).go('/users/detail/${element.id}');
                    },
                    label: 'View',
                    fgColor: AppColors.primary500,
                    textStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
