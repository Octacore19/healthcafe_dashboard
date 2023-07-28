import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/bloc/users_cubit.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/widgets/pagination_footer.dart';
import 'package:healthcafe_dashboard/widgets/search_filter_view.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';
import 'package:healthcafe_dashboard/widgets/title_subtitle_view.dart';
import 'package:intl/intl.dart';

class UsersPage extends AppPage {
  const UsersPage({
    required super.args,
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
    List<Widget> children = [];
    Widget buildHeaderItem() {
      return Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16).r,
        color: AppColors.grey50,
        child: Row(
          children: [
            Expanded(child: Text('Date Joined', style: style, maxLines: 1)),
            Expanded(
                flex: 2, child: Text('Full name', style: style, maxLines: 1)),
            Expanded(flex: 2, child: Text('Email', style: style, maxLines: 1)),
            Expanded(
                flex: 2,
                child: Text('Phone Number', style: style, maxLines: 1)),
            Expanded(
                flex: 2, child: Text('Address', style: style, maxLines: 1)),
            Expanded(child: Text('HMO', style: style, maxLines: 1)),
            Expanded(child: Text('Status', style: style, maxLines: 1)),
          ],
        ),
      );
    }

    Widget buildItem(AuthUser value) {
      style = style.copyWith(color: AppColors.grey600);

      final formatter = DateFormat('dd-MM-yyyy');
      final creationDate =
          value.dateCreated != null ? formatter.format(value.dateCreated!) : '';
      return Container(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16).r,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.gray200),
          ),
        ),
        child: Row(
          children: [
            Expanded(child: Text(creationDate, style: style, maxLines: 1)),
            Expanded(
                flex: 2, child: Text(value.name, style: style, maxLines: 1)),
            Expanded(
                flex: 2, child: Text(value.email, style: style, maxLines: 1)),
            Expanded(
                flex: 2, child: Text(value.phone, style: style, maxLines: 1)),
            Expanded(flex: 2, child: Text('', style: style, maxLines: 1)),
            Expanded(child: Text('', style: style, maxLines: 1)),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: Text('active', style: style, maxLines: 1)),
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
      );
    }

    children.add(buildHeaderItem());

    for (var user in users) {
      children.add(buildItem(user));
    }

    Widget buildList() {
      return SingleChildScrollView(
        child: Card(
          elevation: 0.5,
          margin: EdgeInsets.zero,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10).r,
            side: const BorderSide(color: AppColors.gray200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.59,
      child: TabBarView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          buildList(),
          buildList(),
          buildList(),
          buildList(),
        ],
      ),
    );
  }
}
