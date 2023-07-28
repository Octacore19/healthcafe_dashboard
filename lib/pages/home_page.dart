import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcafe_dashboard/domain/models/homepage.dart';
import 'package:healthcafe_dashboard/res/colors.dart';
import 'package:healthcafe_dashboard/res/images.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/home_router_cubit.dart';
import 'package:healthcafe_dashboard/routing/home_router_delegate.dart';

class HomePage extends AppPage {
  const HomePage({required super.args, super.key});

  @override
  Widget build(BuildContext context) {
    final page = args['page'] ?? 0;

    final parent = Router.of(context).backButtonDispatcher;
    BackButtonDispatcher? childDispatcher;
    if (parent != null) {
      childDispatcher = ChildBackButtonDispatcher(parent);
    }
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeRouterCubit(
          routerCubit: BlocProvider.of(context),
          page: page,
        ),
        child: BlocBuilder<HomeRouterCubit, int>(
          builder: (context, index) {
            final router = BlocProvider.of<HomeRouterCubit>(context);

            final pages = router.pages;
            return Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.175,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: AppColors.primary700,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(36, 24, 36, 24).r,
                          height: 0.15.sh,
                          child: const Image(
                            image: AssetImage(AppImages.dashboardLogo),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            type: MaterialType.transparency,
                            child: buildItems(
                              pages.keys.toList(),
                              index,
                              router.onPageChanged,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Router(
                    backButtonDispatcher: childDispatcher,
                    routerDelegate: HomeRouterDelegate(router),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildItems(List<HomePages> pages, int page, Function(int) onChanged) {
    return ListView.separated(
      itemCount: pages.length,
      separatorBuilder: (_, __) => SizedBox(height: 20.h),
      itemBuilder: (context, index) {
        bool current = page == index;

        final item = pages[index];

        return ListTile(
          onTap: () => onChanged(index),
          selected: current,
          textColor: Colors.white,
          selectedColor: Colors.white,
          selectedTileColor: AppColors.primary500,
          contentPadding: const EdgeInsets.fromLTRB(24, 10, 24, 10).r,
          leading: SvgPicture.asset(
            item.icon,
            colorFilter: current
                ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                : null,
          ),
          title: Text(item.title),
        );
      },
    );
  }
}
