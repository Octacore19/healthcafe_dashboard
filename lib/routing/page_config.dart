import 'package:equatable/equatable.dart';
import 'package:healthcafe_dashboard/routing/app_page.dart';
import 'package:healthcafe_dashboard/routing/app_router.dart';

class PageConfig extends Equatable {
  PageConfig({
    required String? location,
    Map<String, dynamic>? args,
    this.name,
  }) {
    path = Uri.tryParse(location ?? '') ?? Uri.parse('/');

    route = path.toString();

    this.args.addIfNotNull(args);

    page = AppRouter.getPage(this);
  }

  late final Uri path;

  late final String route;

  final String? name;

  final Map<String, dynamic> args = {};

  late final AppPage page;

  @override
  List<Object?> get props => [path, args];

  @override
  String toString() {
    return 'PageConfig: path = $path, args = $args';
  }
}

extension AddNullableMap on Map {
  void addIfNotNull(Map? other) {
    if (other != null) {
      addAll(other);
    }
  }
}
