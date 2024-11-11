

// // main.dart
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:simple_notes_app/Timer/stopwatch.dart';
// import 'package:simple_notes_app/Timer/timer.dart';
// import 'package:simple_notes_app/constants.dart';
// // import 'customizable_stopwatch.dart'; // Import the stopwatch file
// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   bool _isTimerSelected = true; // This will toggle between timer and stopwatch

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Timer & Stopwatch')),
//       body: Center(
//         child: _isTimerSelected
//             ? CustomizableTimer() // Use the full timer logic
//             : CustomizableStopwatch(), // Stopwatch widget logic
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _isTimerSelected = !_isTimerSelected;
//           });
//         },
//         child: Icon(_isTimerSelected ? Icons.timer : Icons.watch_later),
//       ),
//     );
//   }
// }
