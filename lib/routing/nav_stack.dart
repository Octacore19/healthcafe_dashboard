import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/page_config.dart';

class NavStack {
  NavStack(this._stack);

  final List<PageConfig> _stack;

  List<AppPage> get pages => List.unmodifiable(_stack.map((e) => e.page));

  List<PageConfig> get configs => _stack;

  int get length => _stack.length;

  PageConfig get first => _stack.first;

  PageConfig? get last => _stack.isNotEmpty ? _stack.last : null;

  void clear() {
    _stack.removeRange(0, _stack.length - 2);
  }

  bool canPop() => _stack.length > 1;

  NavStack pop() {
    if (canPop()) _stack.remove(_stack.last);
    return NavStack(_stack);
  }

  NavStack clearAll() {
    if (canPop()) _stack.removeRange(1, _stack.length);
    return NavStack(_stack);
  }

  NavStack pushBeneathCurrent(PageConfig config) {
    _stack.insert(_stack.length - 1, config);
    return NavStack(_stack);
  }

  NavStack push(PageConfig config) {
    if (config != _stack.last) _stack.add(config);
    return NavStack(_stack);
  }

  NavStack replace(PageConfig config, [String? prevConfig]) {
    if (canPop()) {
      _stack.removeLast();
      push(config);
    } else {
      _stack.insert(0, config);
      _stack.removeLast();
    }
    return NavStack(_stack);
  }

  NavStack clearAndPush(PageConfig config) {
    _stack.clear();
    _stack.add(config);
    return NavStack(_stack);
  }

  NavStack clearAndPushAll(List<PageConfig> configs) {
    _stack.clear();
    _stack.addAll(configs);
    return NavStack(_stack);
  }

  @override
  String toString() {
    return 'NavStack: stack = $_stack';
  }
}
