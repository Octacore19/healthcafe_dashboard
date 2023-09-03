import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcafe_dashboard/gen/colors.gen.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/widgets/text_button.dart';
import 'package:healthcafe_dashboard/widgets/title_subtitle_view.dart';

class TeamPage extends AppPage {
  const TeamPage({required super.state, super.key});

  @override
  Widget build(BuildContext context) {
    return const _Screen();
  }
}

class _Screen extends StatefulWidget {
  const _Screen({Key? key}) : super(key: key);

  @override
  State<_Screen> createState() => _State();
}

class _State extends State<_Screen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleSubtitleView(
              title: 'Team members',
              subtitle: 'Manage your team members and their account permission here',
              titleSize: 20,
              subtitleSize: 16,
            ),
            Textbutton(
              onTap: () {},
              label: 'Add new member',
              bgColor: ColorName.primary500,
              fgColor: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8).r,
              minimumSize: Size(124.w, 48.h),
            ),
          ],
        ),
      ],
    );
  }
}
