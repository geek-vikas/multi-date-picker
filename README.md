# Multi Date Picker

![pub](https://img.shields.io/badge/pub-v0.0.1--beta.1-blue) ![Multi Date Picker](https://img.shields.io/badge/Multi--Date--Picker-passing-brightgreen)

This package simplifies the process of picking dates from a calendar effortlessly. It offers the flexibility to choose single or multiple dates simply by toggling a boolean.

The package includes convenient features such as `datesToExclude` and `selectedDate`, which make implementing a check-in and check-out flow incredibly straightforward.

With this package, navigating the calendar and selecting dates becomes a piece of cake, providing you with the power to enhance your user experience.

## Usage

The only two required arguments are the `calendarStartDate` and `calendarEndDate`.
The difference between `calendarStartDate` and `calendarEndDate` in days should be greater than 0.

```dart
    import 'package:multi_date_picker/multi_date_picker.dart';

     MultiDatePicker(
        calendarStartDate: DateTime(2024),
        calendarEndDate: DateTime(2024, 4, 30),
    )
```
<video src="https://github.com/geek-vikas/multi-date-picker/assets/95428049/b372e3c1-841e-4cd1-9e61-ea456cc45dea" width="200"/>

### User more parameters to change -- usability, look, and feel of it.

The rest of the parameters are optional

`startDate`
`endDate`
`datesToExclude`
`selectedDates`
`enableMultiSelect`

With this in place, you can almost implement every requirement.

```dart
   import 'package:multi_date_picker/multi_date_picker.dart';

    MultiDatePicker(
        calendarStartDate: DateTime(2024),
        calendarEndDate: DateTime(2024, 4, 30),
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now().add(const Duration(days: 30)),
        calendarStyleConfiguration: CalendarStyleConfiguration(
          backgroundColor: Colors.grey.shade800,
        ),
        datesToExclude: <DateTime>[
          DateTime.now().add(const Duration(days: 1)),
          DateTime.now().add(const Duration(days: 2)),
          DateTime.now().add(const Duration(days: 3)),
        ],
        enableMultiSelect: true,
        enableListener: false,
        onDateSelected: (List<DateTime> dates) {},
    ),
```
<video src="https://github.com/geek-vikas/multi-date-picker/assets/95428049/96c8fdce-feb3-4b1b-b5be-d7544a0e2419" width="200"/>

## Available properties

| Property                     | Type                        | Description                                                                                                      |
| ---------------------------- | --------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| `calendarStartDate`          | DateTime                    | This is the date from which the calendar is starting.                                                            |
| `calendarEndDate`            | DateTime                    | This is the date at which the calendar is ending.                                                                |
| `startDate`                  | DateTime?                   | This is the date from which the user will be able to select the date.                                            |
| `endDate`                    | DateTime?                   | This is the date after which the user will not be able to select any date.                                       |
| `onDateSelected`             | Function(List<DateTime>)?   | This is the callback that will we trigger for the selected dates.                                                |
| `selectedDates`              | List<DateTime>?             | There are the already selected dates.                                                                            |
| `datesToExclude`             | List<DateTime>?             | There are the dates that you want to exclude from the available dates to select.                                 |
| `calendarStyleConfiguration` | CalendarStyleConfiguration? | Use this object to style your calendar.                                                                          |
| `enableListener`             | bool?                       | <br>By default this will be true and this will call `onDateSelected` for every date selected<br>                 |
| `enableMultiSelect`          | bool?                       | Set this to true to enable multi-select                                                                          |

## Upcoming changes

- Enable drag to select
- Range selection. For: Like when the user has to select a download bank statement they have to select a from and to.
- Using app theme as default style configuration.
- More customization options.
- Tap on year to change the current year.
- Allowing more control over the scroll behavior.
- Introducing different layouts to view the calendar.

## Author

This plugin is developed by Vikas Kumar, Senior Software Engineer at [GeekyAnts](https://geekyants.com/).

- [Github](https://github.com/Vikaskumar75)
- [LinkedIn](https://www.linkedin.com/in/vikas-kumar-6564a7185/)
