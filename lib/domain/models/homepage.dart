import 'package:healthcafe_dashboard/res/images.dart';

enum HomePages {
  dashboard,
  users,
  appointments,
  wellness,
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
    }
  }

  String get icon {
    switch (this) {
      case HomePages.dashboard:
        return AppSvgs.threeLayersIcon;
      case HomePages.users:
        return AppSvgs.people;
      case HomePages.appointments:
        return AppSvgs.noteFavorite;
      case HomePages.wellness:
        return AppSvgs.note;
      case HomePages.settings:
        return AppSvgs.setting;
    }
  }
}
