import 'package:flutter/material.dart';
import 'package:multi_date_picker/multi_date_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiDatePicker(
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
    );
  }
}
