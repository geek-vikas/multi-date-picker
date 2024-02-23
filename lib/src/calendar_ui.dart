part of 'multi_date_picker.dart';

class _CalendarUI extends ConsumerStatefulWidget {
  const _CalendarUI({
    required this.dates,
    required this.enableMultiSelect,
    required this.onDateSelected,
    this.scrollController,
  });
  final List<GroupedDatesByYear> dates;
  final bool enableMultiSelect;
  final ScrollController? scrollController;
  final Function(List<DateTime>)? onDateSelected;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectionProvider, _selectionListener);

    return ListView.builder(
      controller: widget.scrollController ?? scrollController,
      itemCount: widget.dates.length,
      itemBuilder: (_, int yearIndex) {
        final GroupedDatesByYear yearDates = widget.dates[yearIndex];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              yearDates.year.toString(),
              style: const TextStyle(
                fontSize: 27,
                color: Color(0xFF204D6C),
                fontWeight: FontWeight.w800,
              ),
            ),
            _MonthWidget(
              months: yearDates.months,
              calendarController: calendarController,
              enableMultiSelect: widget.enableMultiSelect,
            )
          ],
        );
      },
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
  });

  final List<GroupedDatesByMonth> months;
  final CalendarController calendarController;
  final bool enableMultiSelect;

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
              style: const TextStyle(
                fontSize: 21,
                color: Color(0XFF252B5C),
                fontFamily: 'DMSans',
              ),
            ),
            const SizedBox(height: 10),
            _DatesWidget(
              dates: dates,
              enableMultiSelect: enableMultiSelect,
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
  });
  final List<DateTime> dates;
  final bool enableMultiSelect;

  @override
  ConsumerState<_DatesWidget> createState() => _DatesWidgetState();
}

class _DatesWidgetState extends ConsumerState<_DatesWidget> {
  late CalendarController calendarController;
  @override
  void initState() {
    calendarController = CalendarController.instance;
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
              backgroundColor:
                  isSelected ? const Color(0xFF204D6C) : Colors.transparent,
              radius: 4,
              child: Text(
                date.day.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: calendarController.isAvailableForSelection(date)
                      ? isSelected
                          ? Colors.white
                          : const Color(0xFF204D6C)
                      : const Color(0xFF204D6C).withOpacity(0.2),
                  fontWeight: FontWeight.w600,
                ),
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
