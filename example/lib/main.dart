import 'dart:developer';

import 'package:calendar_date_picker/calendar_date_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        initialDate: DateTime.now(),
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now().add(const Duration(days: 30)),
        datesToExclude: const <DateTime>[],
        enableMultiSelect: true,
        onDateSelected: (List<DateTime> dates) {
          log('$dates');
        },
      ),
    );
  }
}
