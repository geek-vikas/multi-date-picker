import 'export.dart';

class GroupedDatesByYear {
  GroupedDatesByYear({required this.year, required this.months});

  final int year;
  final List<GroupedDatesByMonth> months;
}
