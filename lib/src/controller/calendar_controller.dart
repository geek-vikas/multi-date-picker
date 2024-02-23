import '../models/export.dart';
import '../utilities/extensions/on_list.dart';

class CalendarController {
  CalendarController._();
  static final CalendarController instance = CalendarController._();

  final List<GroupedDatesByYear> calendarDates = <GroupedDatesByYear>[];
  final List<DateTime> _datesForSelection = <DateTime>[];

  void setCalendarDates({
    required DateTime calendarStartDate,
    required DateTime calendarEndDate,
  }) {
    calendarDates.clear();
    final DateTime startDate = DateTime(
      calendarStartDate.year,
      calendarStartDate.month,
      calendarStartDate.day,
    );
    final DateTime endDate = DateTime(
      calendarEndDate.year,
      calendarEndDate.month,
      calendarEndDate.day,
    );

    final int noOfDays = endDate.difference(startDate).inDays.abs();

    for (int i = 0; i <= noOfDays; i++) {
      final DateTime date = startDate.add(Duration(days: i));
      final int yearIndex = calendarDates.indexWhere(
        (GroupedDatesByYear e) => e.year == date.year,
      );

      if (yearIndex == -1) {
        final GroupedDatesByYear groupedDate = GroupedDatesByYear(
          year: date.year,
          months: <GroupedDatesByMonth>[
            GroupedDatesByMonth(month: date.month, dates: <DateTime>[date])
          ],
        );

        calendarDates.add(groupedDate);
        continue;
      } else {
        final List<GroupedDatesByMonth> months =
            calendarDates[yearIndex].months;
        final int monthIndex = months.indexWhere(
          (GroupedDatesByMonth e) => e.month == date.month,
        );

        if (monthIndex != -1) {
          months[monthIndex].dates.add(date);
        } else {
          months.add(
            GroupedDatesByMonth(
              month: date.month,
              dates: <DateTime>[
                DateTime(date.year, date.month, date.day),
              ],
            ),
          );
        }
      }
    }
  }

  void setDatesAvailableForSelection({
    required DateTime startDate,
    required DateTime endDate,
    List<DateTime>? datesToExclude,
  }) {
    _datesForSelection.clear();
    final DateTime selectEndDate = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
    );

    final DateTime selectStartDate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );

    final int noOfDays = selectEndDate.difference(selectStartDate).inDays.abs();
    for (int i = 0; i <= noOfDays; i++) {
      final DateTime date = selectStartDate.add(Duration(days: i));
      _datesForSelection.add(
        DateTime(date.year, date.month, date.day),
      );
    }

    if (datesToExclude.isNullOrEmpty()) return;

    for (DateTime date in datesToExclude!) {
      _datesForSelection.removeWhere((DateTime e) => _areDatesEqual(e, date));
    }
  }

  bool isAvailableForSelection(DateTime date) {
    for (DateTime availableDate in _datesForSelection) {
      if (_areDatesEqual(date, availableDate)) {
        return true;
      }
    }

    return false;
  }

  bool _areDatesEqual(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}
