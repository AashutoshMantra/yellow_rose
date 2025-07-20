import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateUtils {
  static final DateFormat _monthFormat = DateFormat('MMMM yyyy');
  static final DateFormat _dayFormat = DateFormat('dd');
  static final DateFormat _firstDayFormat = DateFormat('MMM dd');
  static final DateFormat _dayMonthFormat = DateFormat('d MMM');

  static final DateFormat _firstMonthFormat = DateFormat('MMM');

  static final DateFormat _fullDayFormat = DateFormat('EEE MMM dd, yyyy');
  static final DateFormat _fullDayTimeFormat =
      DateFormat('EEE, d-MM-y, h:mm a');

  static final DateFormat _fullDayWithoutWeekdayTimeFormat =
      DateFormat('d-MM-y, h:mm a');
  static final DateFormat _listDateFormatGlucose = DateFormat('EEE, d MMM');
  static final DateFormat _timeInAmPM = DateFormat('hh:mm a');
  static final DateFormat _timeInAm24 = DateFormat('HH:mm');

  static final DateFormat _apiDayFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
  static final DateFormat _customApiDateFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat _notificationDateFormat = DateFormat("d MMMM y'");

  static final DateFormat _dayFormatSlash = DateFormat('dd/MM/yyyy');
  static final DateFormat _dayMonthYearFormat = DateFormat("dd MMM yyyy");
  static final DateFormat _dayDateMonthYearFormat = DateFormat("E, dd MMM yy");
  static final DateFormat _dayDateMonthFormat = DateFormat("E, dd MMM yy");

  static final DateFormat _hourMinuteFormat = DateFormat.Hm();
  static String givenFormat(DateTime d, String format) =>
      DateFormat(format).format(d);

  static String formatMonth(DateTime d) => _monthFormat.format(d);

  static String formatDay(DateTime d) => _dayFormat.format(d);
  static String formatFirstDay(DateTime d) => _firstDayFormat.format(d);

  static String notificationDateFormat(DateTime d) =>
      _notificationDateFormat.format(d);
  static String formatFirstMonth(DateTime d) => _firstMonthFormat.format(d);
  static String formatDayWithoutWeekdayTimeFormat(DateTime d) =>
      _fullDayWithoutWeekdayTimeFormat.format(d);

  static String fullDayFormat(DateTime d) => _fullDayFormat.format(d);
  static String fullDayTimeFormat(DateTime d) => _fullDayTimeFormat.format(d);

  static String apiDayFormat(DateTime d) => _apiDayFormat.format(d);
  static String hourMinuteDayFormat(DateTime d) => _hourMinuteFormat.format(d);
  static String timeInAmPm(DateTime d) => _timeInAmPM.format(d);
  static String timeIn24(DateTime d) => _timeInAm24.format(d);

  static String dayFormatSlash(DateTime d) => _dayFormatSlash.format(d);
  static String customApiDayFormat(DateTime d) =>
      _customApiDateFormat.format(d);
  static String dayMonthYearFormat(DateTime d) => _dayMonthYearFormat.format(d);

  static String dayDateMonthYearFormat(DateTime d) =>
      _dayDateMonthYearFormat.format(d);
  static String dayDateMonthFormat(DateTime d) => _dayDateMonthFormat.format(d);
  static String listDateFormatGlucose(DateTime d) =>
      _listDateFormatGlucose.format(d);
  static String dayMonthFormat(DateTime d) => _dayMonthFormat.format(d.toUtc());

  static DateTime addMonths(DateTime date, int months) {
    int year = date.year + (date.month + months) ~/ 12;
    int month = (date.month + months) % 12;
    if (month == 0) {
      month = 12;
      year--;
    }
    int day = date.day;
    if (day > 28) {
      int maxDays = DateTime(year, month + 1, 0).day;
      day = day > maxDays ? maxDays : day;
    }
    return DateTime(year, month, day, date.hour, date.minute, date.second,
        date.millisecond, date.microsecond);
  }

  static const List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  static const List months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  /// The list of days in a given month
  static List<DateTime> daysInMonth(DateTime month) {
    var first = firstDayOfMonth(month);
    var daysBefore = first.weekday;
    var firstToDisplay = first.subtract(Duration(days: daysBefore));
    var last = CustomDateUtils.lastDayOfMonth(month);

    var daysAfter = 7 - last.weekday;

    // If the last day is sunday (7) the entire week must be rendered
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    // var lastToDisplay = last.add(Duration(days: daysAfter));
    return daysRange(first, last).toList();
  }

  static Iterable<DateTime> daysRange(DateTime first, DateTime last) {
    var listOfDates = List<DateTime>.generate(
        last.day, (i) => DateTime(first.year, first.month, i + 1));
    return listOfDates;
  }

  static bool isFirstDayOfMonth(DateTime day) {
    return isSameDay(firstDayOfMonth(day), day);
  }

  static bool isLastDayOfMonth(DateTime day) {
    return isSameDay(lastDayOfMonth(day), day);
  }

  static DateTime firstDayOfMonth(DateTime month) {
    return DateTime(month.year, month.month);
  }

  static DateTime getLastSunday(DateTime currentDate) {
    if (currentDate.weekday == DateTime.sunday) {
      return currentDate;
    }

    int difference = currentDate.weekday - DateTime.sunday;
    if (difference < 0) {
      difference += 7;
    }
    // Subtract the difference to get the last Sunday
    DateTime lastSunday = currentDate.subtract(Duration(days: difference));

    return lastSunday;
  }

  static DateTime? getNextWeekdayInDateRange(
      int weekday, DateTime startDate, DateTime endDate) {
    if (weekday < 1 || weekday > 7) {
      throw ArgumentError('Invalid weekday. Should be in the range 1 to 7.');
    }

    DateTime currentDate = startDate;

    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      if (currentDate.weekday == weekday) {
        return currentDate;
      }

      currentDate = currentDate.add(const Duration(days: 1));
    }

    return null;
  }

  static int? getDayAsInt(String day) {
    List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    String lowercasedDay = day.toLowerCase();

    int index = weekDays.indexWhere((d) => d.toLowerCase() == lowercasedDay);

    if (index != -1) {
      return index + 1;
    }

    return null;
  }

  static DateTime firstDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar works from Sunday - Monday
    var decreaseNum = day.weekday % 7;
    return day.subtract(Duration(days: decreaseNum));
  }

  static DateTime lastDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar's Week starts on Sunday
    var increaseNum = day.weekday % 7;
    return day.add(Duration(days: 7 - increaseNum));
  }

  /// The last day of a given month
  static DateTime lastDayOfMonth(DateTime month) {
    var beginningNextMonth = (month.month < 12)
        ? DateTime(month.year, month.month + 1, 1)
        : DateTime(month.year + 1, 1, 1);
    return beginningNextMonth.subtract(const Duration(days: 1));
  }

  /// Returns a [DateTime] for each day the given range.
  ///
  /// [start] inclusive
  /// [end] exclusive
  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
    var i = start;
    var offset = start.timeZoneOffset;
    while (i.day <= end.day) {
      yield i;
      i = i.add(const Duration(days: 1));
      var timeZoneDiff = i.timeZoneOffset - offset;
      if (timeZoneDiff.inSeconds != 0) {
        offset = i.timeZoneOffset;
        i = i.subtract(Duration(seconds: timeZoneDiff.inSeconds));
      }
    }
  }

  /// Whether or not two times are on the same day.
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static DateTime parseObservationDateTime(String? date) {
    return date != null
        ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(date, true).toLocal()
        : DateTime.now();
  }

  static bool isSameWeek(DateTime a, DateTime b) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    a = DateTime.utc(a.year, a.month, a.day);
    b = DateTime.utc(b.year, b.month, b.day);

    var diff = a.toUtc().difference(b.toUtc()).inDays;
    if (diff.abs() >= 7) {
      return false;
    }

    var min = a.isBefore(b) ? a : b;
    var max = a.isBefore(b) ? b : a;
    var result = max.weekday % 7 - min.weekday % 7 >= 0;
    return result;
  }

  static DateTime previousMonth(DateTime m) {
    var year = m.year;
    var month = m.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return DateTime(year, month);
  }

  static DateTime nextMonth(DateTime m) {
    var year = m.year;
    var month = m.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return DateTime(year, month);
  }

  static DateTime previousWeek(DateTime w) {
    return w.subtract(const Duration(days: 7));
  }

  static DateTime nextWeek(DateTime w) {
    return w.add(const Duration(days: 7));
  }

  static List<DateTime> generateWeekdayList(
      DateTime startDate, DateTime endDate) {
    List<DateTime> weekdaysList = [];

    for (DateTime date = startDate;
        date.isBefore(endDate) || CustomDateUtils.isSameDay(date, endDate);
        date = date.add(const Duration(days: 1))) {
      if (date.weekday >= DateTime.monday) {
        weekdaysList.add(date);
      }
    }

    return weekdaysList;
  }

  static TimeOfDay parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return TimeOfDay(hour: hour, minute: minute);
  }

  static String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final minute = time.minute.toString().padLeft(2, '0');

    return '$hour:$minute $period';
  }

  static int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();

    int age = today.year - birthDate.year;

    // Check if the birthday has not occurred yet in the current year
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  static List<String> weekDays = List.generate(7, (index) {
    DateTime day = DateTime(2024, 1, 1).add(Duration(days: index));
    return DateFormat('EEEE').format(day);
  });

  static String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}h ${parts[1].padLeft(2, '0')}m';
  }
}
