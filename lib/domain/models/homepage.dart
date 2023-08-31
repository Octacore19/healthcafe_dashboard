import 'package:healthcafe_dashboard/gen/assets.gen.dart';

enum HomePages {
  dashboard,
  users,
  appointments,
  wellness,
  vaccines,
  assessments,
  settings,
}

extension HomePagesExt on HomePages {
  String get title {
    switch (this) {
      case HomePages.dashboard:
        return 'Dashboard';
      case HomePages.users:
        return 'Users';
      case HomePages.appointments:
        return 'Appointments';
      case HomePages.wellness:
        return 'Wellness Plans';
      case HomePages.settings:
        return 'Settings';
      case HomePages.vaccines:
        return 'Vaccines';
      case HomePages.assessments:
        return 'Assessments';
    }
  }

  SvgGenImage get icon {
    switch (this) {
      case HomePages.dashboard:
        return Assets.img.threeLayers;
      case HomePages.users:
        return Assets.img.people;
      case HomePages.appointments:
        return Assets.img.noteFavorite;
      case HomePages.wellness:
        return Assets.img.note;
      case HomePages.settings:
        return Assets.img.setting;
      case HomePages.vaccines:
        return Assets.img.note;
      case HomePages.assessments:
        return Assets.img.note;
    }
  }
}
