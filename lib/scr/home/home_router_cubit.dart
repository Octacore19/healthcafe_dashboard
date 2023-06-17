import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/routing/app_router.dart';
import 'package:healthcafe_dashboard/routing/nav_stack.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';

class HomeRouterCubit extends Cubit<NavStack> {
  HomeRouterCubit(List<PageConfig> configs) : super(NavStack(configs));

  void push(String path, [Map<String, dynamic>? args]) {
    PageConfig config = PageConfig(location: path, args: args);
    emit(state.push(config));
  }

  void popAndPush(String path, [Map<String, dynamic>? args]) {
    PageConfig config = PageConfig(location: path, args: args);
    state.pop();
    emit(state.push(config));
  }

  void clearAndPush(String path, [Map<String, dynamic>? args]) {
    PageConfig config = PageConfig(location: path, args: args);
    emit(state.clearAndPush(config));
  }

  void pop() {
    emit(state.pop());
  }

  bool canPop() {
    return state.canPop();
  }

  void pushBeneathCurrent(String path, [Map<String, dynamic>? args]) {
    final PageConfig config = PageConfig(location: path, args: args);
    emit(state.pushBeneathCurrent(config));
  }

  void onPageChanged(int page) {
    PageConfig config = PageConfig(location: '');
    switch (page) {
      case 0:
        config = PageConfig(location: AppRouter.dashboard);
        break;
      case 1:
        config = PageConfig(location: AppRouter.test);
        break;
      case 2:
        config = PageConfig(location: AppRouter.appointments);
        break;
      case 3:
        config = PageConfig(location: AppRouter.users);
        break;
    }
    emit(state.clearAndPush(config));
  }
}
