import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utilities/export.dart';

final StateNotifierProvider<SelectionController, List<DateTime>>
    selectionProvider =
    StateNotifierProvider<SelectionController, List<DateTime>>(
  (_) => SelectionController(),
);

class SelectionController extends StateNotifier<List<DateTime>> {
  SelectionController() : super(<DateTime>[]);  

  void setInitialDates(List<DateTime>? dates) {
    if (dates.isNullOrEmpty()) return;
    final List<DateTime> datesWithNoTime = <DateTime>[];
    for (final DateTime date in dates!) {
      datesWithNoTime.add(DateTime(date.year, date.month, date.day));
    }
    state = datesWithNoTime;
  }

  void singleSelect(DateTime date) => state = <DateTime>[date];

  void multiSelect(DateTime date) {
    if (state.contains(date)) {
      final List<DateTime> stateCopy = <DateTime>[...state];
      stateCopy.remove(date);
      state = <DateTime>[...stateCopy];
    } else {
      state = <DateTime>[...state, date];
    }
  }
}
