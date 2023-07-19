import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/routing/nav_stack.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';

class HomeRouterCubit extends Cubit<NavStack> {
  HomeRouterCubit(String location)
      : super(NavStack([PageConfig(location: location)]));

  void popAndPush(String path, [Map<String, dynamic>? args]) {
    PageConfig config = PageConfig(location: path, args: args);
    state.pop();
    emit(state.push(config));
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

  void onPageChanged(PageConfig page) {
    emit(state.clearAndPush(page));
  }
}
