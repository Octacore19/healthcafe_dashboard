enum AppointmentType { wellness, vaccine, unknown }

extension AppointmentTypeExt on AppointmentType {
  String get title {
    switch (this) {
      case AppointmentType.wellness:
        return 'Wellness Plan';
      case AppointmentType.vaccine:
        return 'Vaccine';
      case AppointmentType.unknown:
      default:
        return '';
    }
  }
}

extension AppointmentTypeIntExt on int? {
  AppointmentType get appointmentType {
    switch (this) {
      case 0:
        return AppointmentType.wellness;
      case 1:
        return AppointmentType.vaccine;
      case -1:
      default:
        return AppointmentType.unknown;
    }
  }
}
