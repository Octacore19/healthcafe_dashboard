import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/res/images.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';

class UsersPage extends AppPage {
  const UsersPage({
    required super.args,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const UsersScreen();
  }
}

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
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
      body: const Center(
        child: Text('Users Page'),
      ),
    );
  }
}
