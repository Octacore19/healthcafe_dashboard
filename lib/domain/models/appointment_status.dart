enum AppointmentStatus { upcoming, completed, unknown }

extension AppointmentStatusExt on AppointmentStatus {
  String get title {
    switch (this) {
      case AppointmentStatus.upcoming:
        return 'upcoming';
      case AppointmentStatus.completed:
        return 'completed';
      case AppointmentStatus.unknown:
        return 'no status';
    }
  }
}

extension AppointmentStatusIntExt on int? {
  AppointmentStatus get appointmentStatus {
    switch (this) {
      case 0:
        return AppointmentStatus.completed;
      case 1:
        return AppointmentStatus.upcoming;
      case -1:
      default:
        return AppointmentStatus.unknown;
    }
  }
}
