import 'package:intl/intl.dart';

final _dateFormatter = DateFormat('dd-MM-yyyy');
final _timeFormatter = DateFormat('hh:mm a');

extension DateTimeExt on DateTime? {
  String get formatTime {
    final dateTime = this;
    return dateTime == null ? 'Nil' : _timeFormatter.format(dateTime);
  }

  String get formatDate {
    final dateTime = this;
    return dateTime == null ? 'Nil' : _dateFormatter.format(dateTime);
  }
}
