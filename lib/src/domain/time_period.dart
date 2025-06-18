import 'package:intl/intl.dart' as intl;

enum TimePeriod {
  lastDay,
  lastWeek,
  lastMonth;
  // lastYear;

  String get queryString {
    final now = DateTime.now();
    final formatter = intl.DateFormat('yyyy-MM-dd');
    
    switch (this) {
      case TimePeriod.lastDay:
        return formatter.format(now.subtract(const Duration(days: 1)));
      case TimePeriod.lastWeek:
        return formatter.format(now.subtract(const Duration(days: 7)));
      case TimePeriod.lastMonth:
        return formatter.format(DateTime(now.year, now.month - 1, now.day));
      // case TimePeriod.lastYear:
      //   return formatter.format(DateTime(now.year - 1, now.month, now.day));
    }
  }

  String get displayName {
    switch (this) {
      case TimePeriod.lastDay:
        return 'Last Day';
      case TimePeriod.lastWeek:
        return 'Last Week';
      case TimePeriod.lastMonth:
        return 'Last Month';
      // case TimePeriod.lastYear:
      //   return 'Last Year';
    }
  }
}