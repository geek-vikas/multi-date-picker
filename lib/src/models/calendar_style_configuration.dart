part of '../multi_date_picker.dart';

class CalendarStyleConfiguration {
  final Color? backgroundColor;
  final Color? selectionColor;
  final TextStyle? unselectedDateStyle;
  final TextStyle? selectedDateStyle;
  final TextStyle? yearTextStyle;
  final TextStyle? monthTextStyle;
  final TextStyle? dateTextStyle;
  final ButtonStyleConfiguration? buttonStyleConfiguration;

  const CalendarStyleConfiguration({
    this.backgroundColor,
    this.selectionColor,
    this.unselectedDateStyle,
    this.selectedDateStyle,
    this.yearTextStyle,
    this.monthTextStyle,
    this.dateTextStyle,
    this.buttonStyleConfiguration,
  });

  static final CalendarStyleConfiguration defaultStyle =
      CalendarStyleConfiguration(
    backgroundColor: Colors.white,
    selectionColor: const Color(0xFF204D6C),
    unselectedDateStyle: const TextStyle(
      fontSize: 14,
      color: Color(0xFF204D6C),
      fontWeight: FontWeight.w600,
    ),
    selectedDateStyle: const TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    yearTextStyle: const TextStyle(
      fontSize: 27,
      color: Color(0xFF204D6C),
      fontWeight: FontWeight.w800,
    ),
    monthTextStyle: const TextStyle(
      fontSize: 21,
      color: Color(0XFF252B5C),
    ),
    dateTextStyle: const TextStyle(
      fontSize: 14,
      color: Color.fromARGB(93, 49, 72, 88),
      fontWeight: FontWeight.w600,
    ),
    buttonStyleConfiguration: ButtonStyleConfiguration(
      height: 60,
      width: 120,
      buttonText: Strings.confirm,
      buttonTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      alignment: const Alignment(0, 0.94),
      decoration: BoxDecoration(
        color: const Color(0xFF204D6C),
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: -5.0,
            blurRadius: 10.0,
            offset: const Offset(0, 5.0),
          )
        ],
      ),
    ),
  );
}
