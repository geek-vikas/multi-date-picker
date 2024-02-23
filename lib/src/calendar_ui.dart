part of 'multi_date_picker.dart';

class _CalendarUI extends ConsumerStatefulWidget {
  const _CalendarUI({
    required this.dates,
    required this.enableMultiSelect,
    required this.enableListener,
    required this.onDateSelected,
    required this.calendarStyle,
    this.selectedDates,
    this.scrollController,
  });
  final List<GroupedDatesByYear> dates;
  final bool enableMultiSelect;
  final bool enableListener;
  final ScrollController? scrollController;
  final List<DateTime>? selectedDates;
  final Function(List<DateTime>)? onDateSelected;
  final CalendarStyleConfiguration? calendarStyle;

  @override
  ConsumerState<_CalendarUI> createState() => _CalendarUIState();
}

class _CalendarUIState extends ConsumerState<_CalendarUI> {
  late CalendarController calendarController;
  late ScrollController scrollController;
  @override
  void initState() {
    calendarController = CalendarController.instance;
    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(selectionProvider.notifier)
          .setInitialDates(widget.selectedDates);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enableListener) {
      ref.listen(selectionProvider, _selectionListener);
    }

    return Stack(
      children: <Widget>[
        ListView.builder(
          controller: widget.scrollController ?? scrollController,
          itemCount: widget.dates.length,
          itemBuilder: (_, int yearIndex) {
            final GroupedDatesByYear yearDates = widget.dates[yearIndex];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  yearDates.year.toString(),
                  style: widget.calendarStyle?.yearTextStyle ??
                      CalendarStyleConfiguration.defaultStyle.yearTextStyle,
                ),
                _MonthWidget(
                  months: yearDates.months,
                  calendarController: calendarController,
                  enableMultiSelect: widget.enableMultiSelect,
                  calendarStyle: widget.calendarStyle,
                )
              ],
            );
          },
        ),
        if (!widget.enableListener)
          Button(
            onDateSelected: widget.onDateSelected,
            style: widget.calendarStyle,
          )
      ],
    );
  }

  void _selectionListener(
    List<DateTime>? previousDates,
    List<DateTime> updatedDates,
  ) {
    widget.onDateSelected?.call(updatedDates);
  }
}

class _MonthWidget extends StatelessWidget {
  const _MonthWidget({
    required this.months,
    required this.calendarController,
    required this.enableMultiSelect,
    required this.calendarStyle,
  });

  final List<GroupedDatesByMonth> months;
  final CalendarController calendarController;
  final bool enableMultiSelect;
  final CalendarStyleConfiguration? calendarStyle;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: months.length,
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (_, int monthIndex) {
        final List<DateTime> dates = months[monthIndex].dates;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              calendarController.getMonthName(months[monthIndex].month),
              style: calendarStyle?.monthTextStyle ??
                  CalendarStyleConfiguration.defaultStyle.monthTextStyle,
            ),
            const SizedBox(height: 10),
            _DatesWidget(
              dates: dates,
              enableMultiSelect: enableMultiSelect,
              calendarStyle: calendarStyle,
            ),
          ],
        );
      },
    );
  }
}

class _DatesWidget extends ConsumerStatefulWidget {
  const _DatesWidget({
    required this.dates,
    required this.enableMultiSelect,
    required this.calendarStyle,
  });
  final List<DateTime> dates;
  final bool enableMultiSelect;
  final CalendarStyleConfiguration? calendarStyle;

  @override
  ConsumerState<_DatesWidget> createState() => _DatesWidgetState();
}

class _DatesWidgetState extends ConsumerState<_DatesWidget> {
  late CalendarController calendarController;
  late CalendarStyleConfiguration defaultStyle;
  @override
  void initState() {
    calendarController = CalendarController.instance;
    defaultStyle = CalendarStyleConfiguration.defaultStyle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<DateTime> selectedDates = ref.watch(selectionProvider);
    return GridView.builder(
        itemCount: widget.dates.length,
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        itemBuilder: (_, int index) {
          final DateTime date = widget.dates[index];
          final bool isSelected = selectedDates.contains(date);

          return GestureDetector(
            onTap: () => _onDateTap(date),
            child: CircleAvatar(
              backgroundColor: isSelected
                  ? widget.calendarStyle?.selectionColor ??
                      defaultStyle.selectionColor
                  : Colors.transparent,
              radius: 4,
              child: Text(
                date.day.toString(),
                style: calendarController.isAvailableForSelection(date)
                    ? isSelected
                        ? widget.calendarStyle?.selectedDateStyle ??
                            defaultStyle.selectedDateStyle
                        : widget.calendarStyle?.unselectedDateStyle ??
                            defaultStyle.unselectedDateStyle
                    : widget.calendarStyle?.dateTextStyle ??
                        defaultStyle.dateTextStyle,
              ),
            ),
          );
        });
  }

  void _onDateTap(DateTime date) {
    if (!calendarController.isAvailableForSelection(date)) return;

    final SelectionController controller = ref.read(selectionProvider.notifier);

    if (widget.enableMultiSelect) {
      controller.multiSelect(date);
    } else {
      controller.singleSelect(date);
    }
  }
}
