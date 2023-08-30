import 'package:intl/intl.dart';

final df = NumberFormat('#,##0.##');

extension NumberFormatter on num? {
  String get percent {
    return '${df.format(this)}%';
  }
}
