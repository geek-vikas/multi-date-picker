import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/export.dart';
import 'models/export.dart';

part 'calendar_ui.dart';

class MultiDatePicker extends StatefulWidget {
  MultiDatePicker({
    super.key,
    required this.calendarStartDate,
    required this.calendarEndDate,
    required this.initialDate,
    this.startDate,
    this.endDate,
    this.onDateSelected,
    this.datesToExclude,
    this.scrollController,
    this.enableListener = true,
    this.enableMultiSelect = false,
  })  : assert(calendarEndDate.difference(calendarStartDate).inDays > 0),
        assert(startDate == null || startDate.isBefore(endDate!)),
        assert(endDate == null || endDate.isAfter(startDate!));

  /// `calendarStartDate` and `calendarEndDate` are the start and end dates of the calendar.
  /// The difference inDays between `calendarEndDate` and `calendarStartDate` should be greater than 0.
  final DateTime calendarStartDate;

  /// `calendarEndDate` determines the end date of the calendar.
  final DateTime calendarEndDate;

  /// `initialDate` is the date from where the calendar view will start.
  final DateTime initialDate;

  /// `startDate` is the start date of calendar. Starting where the dates will be enabled.
  /// By default this will be equal to `calendarStartDate`.
  final DateTime? startDate;

  /// `endDate` is the start date of calendar. Starting where the dates will be enabled.
  /// By default this will be equal to `calendarEndDate`.
  final DateTime? endDate;

  /// `datesToExclude` is a list of dates that will be refrained from selection.
  /// If `datesToExclude` is null, all dates between `startDate` and `endDate` will be available for selection.
  final List<DateTime>? datesToExclude;

  /// `enableListener` determines whether the whether you will get an event on every date selection.
  /// By default this will be `true`.
  /// If `enableListener` is `false`, `onDateSelected` will not be called on date selection.
  /// If this is set to false a confirm button will be shown to get the selected dates.
  final bool enableListener;

  /// `enableMultiSelect` determines whether the calendar will allow multi date selection or not.
  /// By default this will be `false`.
  final bool enableMultiSelect;

  /// `scrollController` is the scroll controller for the calendar.
  /// If this value is null, the calendar will create a scroll automatically to `initialDate`.
  final ScrollController? scrollController;

  /// `onDateSelected` is a callback that will be called on date selection.
  /// Note that this will be triggered for every date change if `enableListener` is `true`.
  /// If you want to change this behavior you can use `enableListener` to `false`.
  /// Then a confirm button will be shown to get the selected dates.
  final Function(List<DateTime>)? onDateSelected;

  @override
  State<MultiDatePicker> createState() => _CalendarDateSelectorState();
}

class _CalendarDateSelectorState extends State<MultiDatePicker> {
  late CalendarController calendarController;

  @override
  void initState() {
    calendarController = CalendarController.instance;
    calendarController.setCalendarDates(
      calendarStartDate: widget.calendarStartDate,
      calendarEndDate: widget.calendarEndDate,
    );

    calendarController.setDatesAvailableForSelection(
      startDate: widget.startDate ?? widget.calendarStartDate,
      endDate: widget.endDate ?? widget.calendarEndDate,
      datesToExclude: widget.datesToExclude,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: _CalendarUI(
        dates: calendarController.calendarDates,
        enableMultiSelect: widget.enableMultiSelect,
        scrollController: widget.scrollController,
        onDateSelected: widget.onDateSelected,
      ),
    );
  }
}
