// import 'package:flutter/material.dart';
// import 'dart:async';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Timer & Stopwatch',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MainPage(),
//     );
//   }
// }class MainPage extends StatefulWidget {
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
//         child: SingleChildScrollView( // This ensures the Column can be scrollable and avoid infinite height
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Show either Timer or Stopwatch based on the toggle
//              Expanded(
//   child: _isTimerSelected ? CustomizableTimer() : CustomizableStopwatch(),
// )
// ,
//               SizedBox(height: 20),
//               // Toggle switch for switching between Timer and Stopwatch
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Timer'),
//                   Switch(
//                     value: _isTimerSelected,
//                     onChanged: (bool value) {
//                       setState(() {
//                         _isTimerSelected = value;
//                       });
//                     },
//                   ),
//                   Text('Stopwatch'),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// // class MainPage extends StatefulWidget {
// //   @override
// //   _MainPageState createState() => _MainPageState();
// // }

// // class _MainPageState extends State<MainPage> {
// //   bool _isTimerSelected = true; // This will toggle between timer and stopwatch

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Timer & Stopwatch')),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             _isTimerSelected ? CustomizableTimer() : CustomizableStopwatch(), // Display either timer or stopwatch
// //             SizedBox(height: 20),
// //             SwitchListTile(
// //               title: Text(_isTimerSelected ? 'Switch to Stopwatch' : 'Switch to Timer'),
// //               value: _isTimerSelected,
// //               onChanged: (bool value) {
// //                 setState(() {
// //                   _isTimerSelected = value; // Toggle between timer and stopwatch
// //                 });
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// class CustomizableTimer extends StatefulWidget {
//   @override
//   _CustomizableTimerState createState() => _CustomizableTimerState();
// }

// class _CustomizableTimerState extends State<CustomizableTimer> {
//   int _timerDuration = 1; // Default duration in minutes
//   String _timerText = '1:00';
//   int _remainingSeconds = 0;
//   bool _isRunning = false;
//   bool _showPauseButton = false;
//   bool _showContinueButton = false;
//   Timer? _timer;

//   void startTimer(int minutes) {
//     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (seconds > 0) {
//           seconds--;
//           int minutes = seconds ~/ 60;
//           int remainingSeconds = seconds % 60;
//           _timerText =
//               '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
//           _remainingSeconds = seconds;
//         } else {
//           _timer?.cancel();
//           _isRunning = false;
//           _showPauseButton = false;
//           _showContinueButton = false;
//         }
//       });
//     });
//     _isRunning = true;
//     _showPauseButton = true;
//     _showContinueButton = false;
//   }

//   void pauseTimer() {
//     if (_isRunning) {
//       _timer?.cancel();
//       _isRunning = false;
//       _showPauseButton = false;
//       _showContinueButton = true;
//     }
//     setState(() {});
//   }

//   void restartTimer() {
//     pauseTimer();
//     setState(() {
//       _remainingSeconds = 0;
//       _timerText = '$_timerDuration:00';
//       _showPauseButton = false;
//       _showContinueButton = false;
//     });
//   }

//   void continueTimer() {
//     if (!_isRunning) {
//       _isRunning = true;
//       startTimer(_remainingSeconds ~/ 60);
//       _showPauseButton = true;
//       _showContinueButton = false;
//     }
//     setState(() {});
//   }

//   void increaseTime() {
//     setState(() {
//       _timerDuration++;
//       _timerText = '$_timerDuration:00';
//     });
//   }

//   void decreaseTime() {
//     if (_timerDuration > 1) {
//       setState(() {
//         _timerDuration--;
//         _timerText = '$_timerDuration:00';
//       });
//     }
//   }

//   Future<void> _showEditTimeDialog() async {
//     TextEditingController controller =
//         TextEditingController(text: _timerDuration.toString());

//     await showDialog<void>(context: context, builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Set Timer Duration'),
//         content: TextFormField(
//           controller: controller,
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//             labelText: 'Enter time in minutes',
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               if (controller.text.isNotEmpty) {
//                 int newValue = int.parse(controller.text);
//                 if (newValue > 0) {
//                   setState(() {
//                     _timerDuration = newValue;
//                     restartTimer();
//                   });
//                   Navigator.pop(context);
//                 }
//               }
//             },
//             child: Text('OK'),
//           ),
//         ],
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ListView(
//           children: [
//             SizedBox(height: 200),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 30),
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     SizedBox(
//                       width: 200,
//                       height: 200,
//                       child: CircularProgressIndicator(
//                         value: _isRunning
//                             ? 1 - (_remainingSeconds / (_timerDuration * 60.0))
//                             : 0,
//                         backgroundColor: Colors.grey[100],
//                         valueColor:
//                             AlwaysStoppedAnimation<Color>(Colors.pink),
//                         strokeWidth: 10,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Text(
//                         _timerText,
//                         style: TextStyle(fontSize: 30, color: Colors.grey),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 if (!_isRunning && !_showPauseButton && !_showContinueButton)
//                   Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ElevatedButton(
//                             onPressed: _showEditTimeDialog,
//                             child: Text('Set Timer'),
//                           ),
//                           SizedBox(width: 20),
//                           ElevatedButton(
//                             onPressed: () {
//                               if (!_isRunning) {
//                                 startTimer(_timerDuration);
//                               }
//                             },
//                             child: Text('Start'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     if (_showPauseButton)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 5),
//                         child: ElevatedButton(
//                           onPressed: pauseTimer,
//                           child: Text('Pause'),
//                         ),
//                       ),
//                     if (_showContinueButton)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 5),
//                         child: ElevatedButton(
//                           onPressed: continueTimer,
//                           child: Text('Resume'),
//                         ),
//                       ),
//                     if (_isRunning || _showPauseButton || _showContinueButton)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 5),
//                         child: ElevatedButton(
//                           onPressed: restartTimer,
//                           child: Text('Cancel'),
//                         ),
//                       ),
//                   ],
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }

// class CustomizableStopwatch extends StatefulWidget {
//   @override
//   _CustomizableStopwatchState createState() => _CustomizableStopwatchState();
// }

// class _CustomizableStopwatchState extends State<CustomizableStopwatch> {
//   int _seconds = 0;
//   int _minutes = 0;
//   Timer? _timer;
//   bool _isRunning = false;

//   void startStopwatch() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         _seconds++;
//         if (_seconds == 60) {
//           _seconds = 0;
//           _minutes++;
//         }
//       });
//     });
//     _isRunning = true;
//   }

//   void stopStopwatch() {
//     _timer?.cancel();
//     _isRunning = false;
//   }

//   void resetStopwatch() {
//     stopStopwatch();
//     setState(() {
//       _seconds = 0;
//       _minutes = 0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               '$_minutes:${_seconds.toString().padLeft(2, '0')}',
//               style: TextStyle(fontSize: 50),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: _isRunning ? null : startStopwatch,
//                   child: Text('Start'),
//                 ),
//                 SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: _isRunning ? stopStopwatch : null,
//                   child: Text('Stop'),
//                 ),
//                 SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: resetStopwatch,
//                   child: Text('Reset'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'dart:async';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Timer & Stopwatch',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: MainPage(),
// //     );
// //   }
// // }

// // class MainPage extends StatefulWidget {
// //   @override
// //   _MainPageState createState() => _MainPageState();
// // }

// // class _MainPageState extends State<MainPage> {
// //   bool _isTimerSelected = true; // This will toggle between timer and stopwatch

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Timer & Stopwatch')),
// //       body: Center(
// //         child: _isTimerSelected
// //             ? CustomizableTimer() // Use the full timer logic
// //             : CustomizableStopwatch(), // Stopwatch widget logic
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           setState(() {
// //             _isTimerSelected = !_isTimerSelected;
// //           });
// //         },
// //         child: Icon(_isTimerSelected ? Icons.timer : Icons.watch_later),
// //       ),
// //     );
// //   }
// // }

// // class CustomizableTimer extends StatefulWidget {
// //   @override
// //   _CustomizableTimerState createState() => _CustomizableTimerState();
// // }

// // class _CustomizableTimerState extends State<CustomizableTimer> {
// //   int _timerDuration = 1; // Default duration in minutes
// //   String _timerText = '1:00';
// //   int _remainingSeconds = 0;
// //   bool _isRunning = false;
// //   bool _showPauseButton = false;
// //   bool _showContinueButton = false;
// //   Timer? _timer;

// //   void startTimer(int minutes) {
// //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// //       setState(() {
// //         if (seconds > 0) {
// //           seconds--;
// //           int minutes = seconds ~/ 60;
// //           int remainingSeconds = seconds % 60;
// //           _timerText =
// //               '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// //           _remainingSeconds = seconds;
// //         } else {
// //           _timer?.cancel();
// //           _isRunning = false;
// //           _showPauseButton = false;
// //           _showContinueButton = false;
// //         }
// //       });
// //     });
// //     _isRunning = true;
// //     _showPauseButton = true;
// //     _showContinueButton = false;
// //   }

// //   void pauseTimer() {
// //     if (_isRunning) {
// //       _timer?.cancel();
// //       _isRunning = false;
// //       _showPauseButton = false;
// //       _showContinueButton = true;
// //     }
// //     setState(() {});
// //   }

// //   void restartTimer() {
// //     pauseTimer();
// //     setState(() {
// //       _remainingSeconds = 0;
// //       _timerText = '$_timerDuration:00';
// //       _showPauseButton = false;
// //       _showContinueButton = false;
// //     });
// //   }

// //   void continueTimer() {
// //     if (!_isRunning) {
// //       _isRunning = true;
// //       startTimer(_remainingSeconds ~/ 60);
// //       _showPauseButton = true;
// //       _showContinueButton = false;
// //     }
// //     setState(() {});
// //   }

// //   void increaseTime() {
// //     setState(() {
// //       _timerDuration++;
// //       _timerText = '$_timerDuration:00';
// //     });
// //   }

// //   void decreaseTime() {
// //     if (_timerDuration > 1) {
// //       setState(() {
// //         _timerDuration--;
// //         _timerText = '$_timerDuration:00';
// //       });
// //     }
// //   }

// //   Future<void> _showEditTimeDialog() async {
// //     TextEditingController controller =
// //         TextEditingController(text: _timerDuration.toString());

// //     await showDialog<void>(context: context, builder: (BuildContext context) {
// //       return AlertDialog(
// //         title: Text('Set Timer Duration'),
// //         content: TextFormField(
// //           controller: controller,
// //           keyboardType: TextInputType.number,
// //           decoration: InputDecoration(
// //             labelText: 'Enter time in minutes',
// //           ),
// //         ),
// //         actions: <Widget>[
// //           TextButton(
// //             onPressed: () {
// //               Navigator.pop(context);
// //             },
// //             child: Text('Cancel'),
// //           ),
// //           TextButton(
// //             onPressed: () {
// //               if (controller.text.isNotEmpty) {
// //                 int newValue = int.parse(controller.text);
// //                 if (newValue > 0) {
// //                   setState(() {
// //                     _timerDuration = newValue;
// //                     restartTimer();
// //                   });
// //                   Navigator.pop(context);
// //                 }
// //               }
// //             },
// //             child: Text('OK'),
// //           ),
// //         ],
// //       );
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: ListView(
// //           children: [
// //             SizedBox(height: 200),
// //             Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 SizedBox(height: 30),
// //                 Stack(
// //                   alignment: Alignment.center,
// //                   children: [
// //                     SizedBox(
// //                       width: 200,
// //                       height: 200,
// //                       child: CircularProgressIndicator(
// //                         value: _isRunning
// //                             ? 1 - (_remainingSeconds / (_timerDuration * 60.0))
// //                             : 0,
// //                         backgroundColor: Colors.grey[100],
// //                         valueColor:
// //                             AlwaysStoppedAnimation<Color>(Colors.pink),
// //                         strokeWidth: 10,
// //                       ),
// //                     ),
// //                     GestureDetector(
// //                       onTap: () {},
// //                       child: Text(
// //                         _timerText,
// //                         style: TextStyle(fontSize: 30, color: Colors.grey),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(height: 20),
// //                 if (!_isRunning && !_showPauseButton && !_showContinueButton)
// //                   Column(
// //                     children: [
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           ElevatedButton(
// //                             onPressed: _showEditTimeDialog,
// //                             child: Text('Set Timer'),
// //                           ),
// //                           SizedBox(width: 20),
// //                           ElevatedButton(
// //                             onPressed: () {
// //                               if (!_isRunning) {
// //                                 startTimer(_timerDuration);
// //                               }
// //                             },
// //                             child: Text('Start'),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     if (_showPauseButton)
// //                       Padding(
// //                         padding: const EdgeInsets.symmetric(horizontal: 5),
// //                         child: ElevatedButton(
// //                           onPressed: pauseTimer,
// //                           child: Text('Pause'),
// //                         ),
// //                       ),
// //                     if (_showContinueButton)
// //                       Padding(
// //                         padding: const EdgeInsets.symmetric(horizontal: 5),
// //                         child: ElevatedButton(
// //                           onPressed: continueTimer,
// //                           child: Text('Resume'),
// //                         ),
// //                       ),
// //                     if (_isRunning || _showPauseButton || _showContinueButton)
// //                       Padding(
// //                         padding: const EdgeInsets.symmetric(horizontal: 5),
// //                         child: ElevatedButton(
// //                           onPressed: restartTimer,
// //                           child: Text('Cancel'),
// //                         ),
// //                       ),
// //                   ],
// //                 )
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _timer?.cancel();
// //     super.dispose();
// //   }
// // }

// // class CustomizableStopwatch extends StatefulWidget {
// //   @override
// //   _CustomizableStopwatchState createState() => _CustomizableStopwatchState();
// // }

// // class _CustomizableStopwatchState extends State<CustomizableStopwatch> {
// //   int _seconds = 0;
// //   int _minutes = 0;
// //   Timer? _timer;
// //   bool _isRunning = false;

// //   void startStopwatch() {
// //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// //       setState(() {
// //         _seconds++;
// //         if (_seconds == 60) {
// //           _seconds = 0;
// //           _minutes++;
// //         }
// //       });
// //     });
// //     _isRunning = true;
// //   }

// //   void stopStopwatch() {
// //     _timer?.cancel();
// //     _isRunning = false;
// //   }

// //   void resetStopwatch() {
// //     stopStopwatch();
// //     setState(() {
// //       _seconds = 0;
// //       _minutes = 0;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(
// //               '$_minutes:${_seconds.toString().padLeft(2, '0')}',
// //               style: TextStyle(fontSize: 50),
// //             ),
// //             SizedBox(height: 20),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 ElevatedButton(
// //                   onPressed: _isRunning ? null : startStopwatch,
// //                   child: Text('Start'),
// //                 ),
// //                 SizedBox(width: 10),
// //                 ElevatedButton(
// //                   onPressed: _isRunning ? stopStopwatch : null,
// //                   child: Text('Stop'),
// //                 ),
// //                 SizedBox(width: 10),
// //                 ElevatedButton(
// //                   onPressed: resetStopwatch,
// //                   child: Text('Reset'),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }



// // // // main.dart
// // // import 'dart:async';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter/services.dart';
// // // import 'package:simple_notes_app/Timer/stopwatch.dart';
// // // import 'package:simple_notes_app/constants.dart';
// // // // import 'customizable_stopwatch.dart'; // Import the stopwatch file




// // // class CustomizableTimer extends StatefulWidget {
// // //   @override
// // //   _CustomizableTimerState createState() => _CustomizableTimerState();
// // // }

// // // class _CustomizableTimerState extends State<CustomizableTimer> {
// // //   int _timerDuration = 1; // Default duration in minutes
// // //   String _timerText = '1:00';
// // //   int _remainingSeconds = 0;
// // //   bool _isRunning = false;
// // //   bool _showPauseButton = false;
// // //   bool _showContinueButton = false;
// // //   Timer? _timer;

// // //   void startTimer(int minutes) {
// // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // //       setState(() {
// // //         if (seconds > 0) {
// // //           seconds--;
// // //           int minutes = seconds ~/ 60;
// // //           int remainingSeconds = seconds % 60;
// // //           _timerText =
// // //               '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // //           _remainingSeconds = seconds;
// // //         } else {
// // //           _timer?.cancel();
// // //           _isRunning = false;
// // //           _showPauseButton = false;
// // //           _showContinueButton = false;
// // //         }
// // //       });
// // //     });
// // //     _isRunning = true;
// // //     _showPauseButton = true;
// // //     _showContinueButton = false;
// // //   }

// // //   void pauseTimer() {
// // //     if (_isRunning) {
// // //       _timer?.cancel();
// // //       _isRunning = false;
// // //       _showPauseButton = false;
// // //       _showContinueButton = true;
// // //     }
// // //     setState(() {});
// // //   }

// // //   void restartTimer() {
// // //     pauseTimer();
// // //     setState(() {
// // //       _remainingSeconds = 0;
// // //       _timerText = '$_timerDuration:00';
// // //       _showPauseButton = false;
// // //       _showContinueButton = false;
// // //     });
// // //   }

// // //   void continueTimer() {
// // //     if (!_isRunning) {
// // //       _isRunning = true;
// // //       startTimer(_remainingSeconds ~/ 60);
// // //       _showPauseButton = true;
// // //       _showContinueButton = false;
// // //     }
// // //     setState(() {});
// // //   }

// // //   void increaseTime() {
// // //     setState(() {
// // //       _timerDuration++;
// // //       _timerText = '$_timerDuration:00';
// // //     });
// // //   }

// // //   void decreaseTime() {
// // //     if (_timerDuration > 1) {
// // //       setState(() {
// // //         _timerDuration--;
// // //         _timerText = '$_timerDuration:00';
// // //       });
// // //     }
// // //   }

// // //   Future<void> _showEditTimeDialog() async {
// // //     TextEditingController controller =
// // //         TextEditingController(text: _timerDuration.toString());

// // //     await showDialog<void>(context: context, builder: (BuildContext context) {
// // //       return AlertDialog(
// // //         title: Text('Set Timer Duration'),
// // //         content: TextFormField(
// // //           controller: controller,
// // //           keyboardType: TextInputType.number,
// // //           decoration: InputDecoration(
// // //             labelText: 'Enter time in minutes',
// // //           ),
// // //         ),
// // //         actions: <Widget>[
// // //           TextButton(
// // //             onPressed: () {
// // //               Navigator.pop(context);
// // //             },
// // //             child: Text('Cancel'),
// // //           ),
// // //           TextButton(
// // //             onPressed: () {
// // //               if (controller.text.isNotEmpty) {
// // //                 int newValue = int.parse(controller.text);
// // //                 if (newValue > 0) {
// // //                   setState(() {
// // //                     _timerDuration = newValue;
// // //                     restartTimer();
// // //                   });
// // //                   Navigator.pop(context);
// // //                 }
// // //               }
// // //             },
// // //             child: Text('OK'),
// // //           ),
// // //         ],
// // //       );
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Center(
// // //         child: ListView(
// // //           children: [
// // //             SizedBox(height: 200),
// // //             Column(
// // //               mainAxisAlignment: MainAxisAlignment.center,
// // //               children: [
// // //                 SizedBox(height: 30),
// // //                 Stack(
// // //                   alignment: Alignment.center,
// // //                   children: [
// // //                     SizedBox(
// // //                       width: 200,
// // //                       height: 200,
// // //                       child: CircularProgressIndicator(
// // //                         value: _isRunning
// // //                             ? 1 - (_remainingSeconds / (_timerDuration * 60.0))
// // //                             : 0,
// // //                         backgroundColor: Colors.grey[100],
// // //                         valueColor:
// // //                             AlwaysStoppedAnimation<Color>(Colors.pink),
// // //                         strokeWidth: 10,
// // //                       ),
// // //                     ),
// // //                     GestureDetector(
// // //                       onTap: () {},
// // //                       child: Text(
// // //                         _timerText,
// // //                         style: TextStyle(fontSize: 30, color: Colors.grey),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 SizedBox(height: 20),
// // //                 if (!_isRunning && !_showPauseButton && !_showContinueButton)
// // //                   Column(
// // //                     children: [
// // //                       Row(
// // //                         mainAxisAlignment: MainAxisAlignment.center,
// // //                         children: [
// // //                           ElevatedButton(
// // //                             onPressed: _showEditTimeDialog,
// // //                             child: Text('Set Timer'),
// // //                           ),
// // //                           SizedBox(width: 20),
// // //                           ElevatedButton(
// // //                             onPressed: () {
// // //                               if (!_isRunning) {
// // //                                 startTimer(_timerDuration);
// // //                               }
// // //                             },
// // //                             child: Text('Start'),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 Row(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: [
// // //                     if (_showPauseButton)
// // //                       Padding(
// // //                         padding: const EdgeInsets.symmetric(horizontal: 5),
// // //                         child: ElevatedButton(
// // //                           onPressed: pauseTimer,
// // //                           child: Text('Pause'),
// // //                         ),
// // //                       ),
// // //                     if (_showContinueButton)
// // //                       Padding(
// // //                         padding: const EdgeInsets.symmetric(horizontal: 5),
// // //                         child: ElevatedButton(
// // //                           onPressed: continueTimer,
// // //                           child: Text('Resume'),
// // //                         ),
// // //                       ),
// // //                     if (_isRunning || _showPauseButton || _showContinueButton)
// // //                       Padding(
// // //                         padding: const EdgeInsets.symmetric(horizontal: 5),
// // //                         child: ElevatedButton(
// // //                           onPressed: restartTimer,
// // //                           child: Text('Cancel'),
// // //                         ),
// // //                       ),
// // //                   ],
// // //                 )
// // //               ],
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _timer?.cancel();
// // //     super.dispose();
// // //   }
// // // }










// // // // // main.dart
// // // // import 'dart:async';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter/services.dart';
// // // // import 'package:simple_notes_app/Timer/stopwatch.dart';
// // // // import 'package:simple_notes_app/constants.dart';
// // // // // import 'customizable_stopwatch.dart'; // Import the stopwatch file

// // // // void main() {
// // // //   SystemChrome.setSystemUIOverlayStyle(
// // // //       const SystemUiOverlayStyle(statusBarColor: Color(0xFF3C8243)));
// // // //   runApp(MaterialApp(
// // // //     debugShowCheckedModeBanner: false,
// // // //     home: CustomizableTimer(),
// // // //   ));
// // // // }

// // // // class CustomizableTimer extends StatefulWidget {
// // // //   @override
// // // //   _CustomizableTimerState createState() => _CustomizableTimerState();
// // // // }

// // // // class _CustomizableTimerState extends State<CustomizableTimer> {
// // // //   int _timerDuration = 1; // Default duration in minutes
// // // //   String _timerText = '1:00';
// // // //   int _remainingSeconds = 0;
// // // //   bool _isRunning = false;
// // // //   bool _showPauseButton = false;
// // // //   bool _showContinueButton = false;
// // // //   Timer? _timer;
// // // //   bool _isTimerSelected = true; // Toggle between timer and stopwatch

// // // //   void startTimer(int minutes) {
// // // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // //       setState(() {
// // // //         if (seconds > 0) {
// // // //           seconds--;
// // // //           int minutes = seconds ~/ 60;
// // // //           int remainingSeconds = seconds % 60;
// // // //           _timerText =
// // // //               '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // //           _remainingSeconds = seconds;
// // // //         } else {
// // // //           _timer?.cancel();
// // // //           _isRunning = false;
// // // //           _showPauseButton = false;
// // // //           _showContinueButton = false;
// // // //         }
// // // //       });
// // // //     });
// // // //     _isRunning = true;
// // // //     _showPauseButton = true;
// // // //     _showContinueButton = false;
// // // //   }

// // // //   void pauseTimer() {
// // // //     if (_isRunning) {
// // // //       _timer?.cancel();
// // // //       _isRunning = false;
// // // //       _showPauseButton = false;
// // // //       _showContinueButton = true;
// // // //     }
// // // //     setState(() {});
// // // //   }

// // // //   void restartTimer() {
// // // //     pauseTimer();
// // // //     setState(() {
// // // //       _remainingSeconds = 0;
// // // //       _timerText = '$_timerDuration:00';
// // // //       _showPauseButton = false;
// // // //       _showContinueButton = false;
// // // //     });
// // // //   }

// // // //   void continueTimer() {
// // // //     if (!_isRunning) {
// // // //       _isRunning = true;
// // // //       startTimer(_remainingSeconds ~/ 60);
// // // //       _showPauseButton = true;
// // // //       _showContinueButton = false;
// // // //     }
// // // //     setState(() {});
// // // //   }

// // // //   Future<void> _showEditTimeDialog() async {
// // // //     TextEditingController controller =
// // // //         TextEditingController(text: _timerDuration.toString());

// // // //     await showDialog<void>(context: context, builder: (BuildContext context) {
// // // //       return AlertDialog(
// // // //         title: Text('Set Timer Duration'),
// // // //         content: TextFormField(
// // // //           controller: controller,
// // // //           keyboardType: TextInputType.number,
// // // //           decoration: InputDecoration(
// // // //             labelText: 'Enter time in minutes',
// // // //           ),
// // // //         ),
// // // //         actions: <Widget>[
// // // //           TextButton(
// // // //             onPressed: () {
// // // //               Navigator.pop(context);
// // // //             },
// // // //             child: Text('Cancel', style: TextStyle(color: kprimarycolorpink)),
// // // //           ),
// // // //           TextButton(
// // // //             onPressed: () {
// // // //               if (controller.text.isNotEmpty) {
// // // //                 int newValue = int.parse(controller.text);
// // // //                 if (newValue > 0) {
// // // //                   setState(() {
// // // //                     _timerDuration = newValue;
// // // //                     restartTimer();
// // // //                   });
// // // //                   Navigator.pop(context);
// // // //                 }
// // // //               }
// // // //             },
// // // //             child: Text('OK', style: TextStyle(color: kprimarycolorpink)),
// // // //           ),
// // // //         ],
// // // //       );
// // // //     });
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.white,
// // // //       appBar: AppBar(
// // // //         backgroundColor: kprimarycolorpink,
// // // //         title: Row(
// // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // //           children: [
// // // //             GestureDetector(
// // // //               onTap: () {
// // // //                 setState(() {
// // // //                   _isTimerSelected = true;
// // // //                 });
// // // //               },
// // // //               child: Text(
// // // //                 'Timer',
// // // //                 style: TextStyle(
// // // //                   color: _isTimerSelected ? Colors.white : Colors.grey[400],
// // // //                   fontWeight: FontWeight.bold,
// // // //                   fontSize: 20,
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //             SizedBox(width: 20),
// // // //             GestureDetector(
// // // //               onTap: () {
// // // //                 setState(() {
// // // //                   _isTimerSelected = false;
// // // //                 });
// // // //               },
// // // //               child: Text(
// // // //                 'Stopwatch',
// // // //                 style: TextStyle(
// // // //                   color: !_isTimerSelected ? Colors.white : Colors.grey[400],
// // // //                   fontWeight: FontWeight.bold,
// // // //                   fontSize: 20,
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //         centerTitle: true,
// // // //       ),
// // // //       body: Center(
// // // //         child: _isTimerSelected
// // // //             ? CustomizableTimer() // Existing timer code
// // // //             : CustomizableStopwatch(), // Stopwatch widget
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // // TimerWidget code remains unchanged









// // // // // import 'dart:async';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:flutter/services.dart';
// // // // // import 'package:simple_notes_app/constants.dart';

// // // // // void main() {
// // // // //   SystemChrome.setSystemUIOverlayStyle(
// // // // //       const SystemUiOverlayStyle(statusBarColor: Color(0xFF3C8243)));
// // // // //   runApp(MaterialApp(
// // // // //     debugShowCheckedModeBanner: false,
// // // // //     home: CustomizableTimer(),
// // // // //   ));
// // // // // }

// // // // // class CustomizableTimer extends StatefulWidget {
// // // // //   @override
// // // // //   _CustomizableTimerState createState() => _CustomizableTimerState();
// // // // // }

// // // // // class _CustomizableTimerState extends State<CustomizableTimer> {
// // // // //   int _timerDuration = 1; // Default duration in minutes
// // // // //   String _timerText = '1:00';
// // // // //   int _remainingSeconds = 0;
// // // // //   bool _isRunning = false;
// // // // //   bool _showPauseButton = false;
// // // // //   bool _showContinueButton = false;
// // // // //   Timer? _timer;

// // // // //   void startTimer(int minutes) {
// // // // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // // //       setState(() {
// // // // //         if (seconds > 0) {
// // // // //           seconds--;
// // // // //           int minutes = seconds ~/ 60;
// // // // //           int remainingSeconds = seconds % 60;
// // // // //           _timerText =
// // // // //               '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // // //           _remainingSeconds = seconds;
// // // // //         } else {
// // // // //           _timer?.cancel();
// // // // //           _isRunning = false;
// // // // //           _showPauseButton = false;
// // // // //           _showContinueButton = false;
// // // // //         }
// // // // //       });
// // // // //     });
// // // // //     _isRunning = true;
// // // // //     _showPauseButton = true;
// // // // //     _showContinueButton = false;
// // // // //   }

// // // // //   void pauseTimer() {
// // // // //     if (_isRunning) {
// // // // //       _timer?.cancel();
// // // // //       _isRunning = false;
// // // // //       _showPauseButton = false;
// // // // //       _showContinueButton = true;
// // // // //     }
// // // // //     setState(() {});
// // // // //   }

// // // // //   void restartTimer() {
// // // // //     pauseTimer();
// // // // //     setState(() {
// // // // //       _remainingSeconds = 0;
// // // // //       _timerText = '$_timerDuration:00';
// // // // //       _showPauseButton = false;
// // // // //       _showContinueButton = false;
// // // // //     });
// // // // //   }

// // // // //   void continueTimer() {
// // // // //     if (!_isRunning) {
// // // // //       _isRunning = true;
// // // // //       startTimer(_remainingSeconds ~/ 60);
// // // // //       _showPauseButton = true;
// // // // //       _showContinueButton = false;
// // // // //     }
// // // // //     setState(() {});
// // // // //   }

// // // // //   void increaseTime() {
// // // // //     setState(() {
// // // // //       _timerDuration++;
// // // // //       _timerText = '$_timerDuration:00';
// // // // //     });
// // // // //   }

// // // // //   void decreaseTime() {
// // // // //     if (_timerDuration > 1) {
// // // // //       setState(() {
// // // // //         _timerDuration--;
// // // // //         _timerText = '$_timerDuration:00';
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   Future<void> _showEditTimeDialog() async {
// // // // //     TextEditingController controller =
// // // // //         TextEditingController(text: _timerDuration.toString());

// // // // //     await showDialog<void>(
// // // // //       context: context,
// // // // //       builder: (BuildContext context) {
// // // // //         return AlertDialog(
// // // // //           title: Text('Set Timer Duration'),
// // // // //           content: TextFormField(
// // // // //             controller: controller,
// // // // //             keyboardType: TextInputType.number,
// // // // //             decoration: InputDecoration(
// // // // //               labelText: 'Enter time in minutes',
// // // // //             ),
// // // // //           ),
// // // // //           actions: <Widget>[
// // // // //             TextButton(
// // // // //               onPressed: () {
// // // // //                 Navigator.pop(context);
// // // // //               },
// // // // //               child: Text('Cancel', style: TextStyle(color: kprimarycolorpink)),
// // // // //             ),
// // // // //             TextButton(
// // // // //               onPressed: () {
// // // // //                 if (controller.text.isNotEmpty) {
// // // // //                   int newValue = int.parse(controller.text);
// // // // //                   if (newValue > 0) {
// // // // //                     setState(() {
// // // // //                       _timerDuration = newValue;
// // // // //                       restartTimer();
// // // // //                     });
// // // // //                     Navigator.pop(context);
// // // // //                   }
// // // // //                 }
// // // // //               },
// // // // //               child: Text('OK', style: TextStyle(color: kprimarycolorpink)),
// // // // //             ),
// // // // //           ],
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       backgroundColor: Colors.white,
// // // // //       body: Center(
// // // // //         child: ListView(
// // // // //           children: [
// // // // //             SizedBox(
// // // // //               height: 200,
// // // // //             ),
// // // // //             Column(
// // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // //               children: [
// // // // //                 SizedBox(height: 30),
// // // // //                 Stack(
// // // // //                   alignment: Alignment.center,
// // // // //                   children: [
// // // // //                     SizedBox(
// // // // //                       width: 200,
// // // // //                       height: 200,
// // // // //                       child: CircularProgressIndicator(
// // // // //                         value: _isRunning
// // // // //                             ? 1 - (_remainingSeconds / (_timerDuration * 60.0))
// // // // //                             : 0,
// // // // //                         backgroundColor: Colors.grey[100],
// // // // //                         valueColor:
// // // // //                             AlwaysStoppedAnimation<Color>(kprimarycolorpink),
// // // // //                         strokeWidth: 10,
// // // // //                       ),
// // // // //                     ),
// // // // //                     GestureDetector(
// // // // //                       onTap: () {
// // // // //                         // Optional: Add timer click functionality if needed
// // // // //                       },
// // // // //                       child: Text(
// // // // //                         _timerText,
// // // // //                         style: TextStyle(fontSize: 30, color: Colors.grey),
// // // // //                       ),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //                 SizedBox(height: 20),
// // // // //                 SizedBox(height: 10),
// // // // //                 if (!_isRunning && !_showPauseButton && !_showContinueButton)
// // // // //                   Column(
// // // // //                     children: [
// // // // //                       Row(
// // // // //                         mainAxisAlignment: MainAxisAlignment.center,
// // // // //                         children: [
// // // // //                           ElevatedButton(
// // // // //                             style: ElevatedButton.styleFrom(
// // // // //                               backgroundColor: kprimarycolorpink,
// // // // //                               shape: RoundedRectangleBorder(
// // // // //                                 borderRadius: BorderRadius.circular(15.0),
// // // // //                               ),
// // // // //                             ),
// // // // //                             onPressed: _showEditTimeDialog,
// // // // //                             child: Text('Set Timer',
// // // // //                                 style: TextStyle(color: Colors.white)),
// // // // //                           ),
// // // // //                           SizedBox(
// // // // //                             width: 20,
// // // // //                           ),
// // // // //                           ElevatedButton(
// // // // //                             style: ElevatedButton.styleFrom(
// // // // //                               backgroundColor: kprimarycolorpink,
// // // // //                               shape: RoundedRectangleBorder(
// // // // //                                 borderRadius: BorderRadius.circular(15.0),
// // // // //                               ),
// // // // //                             ),
// // // // //                             onPressed: () {
// // // // //                               if (!_isRunning) {
// // // // //                                 startTimer(_timerDuration);
// // // // //                               }
// // // // //                             },
// // // // //                             child: Text('Start',
// // // // //                                 style: TextStyle(color: Colors.white)),
// // // // //                           ),
// // // // //                         ],
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                 Row(
// // // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // // //                   children: [
// // // // //                     if (_showPauseButton)
// // // // //                       Padding(
// // // // //                         padding: const EdgeInsets.symmetric(
// // // // //                             horizontal: 5, vertical: 10),
// // // // //                         child: ElevatedButton(
// // // // //                           style: ElevatedButton.styleFrom(
// // // // //                             backgroundColor: kprimarycolorpink,
// // // // //                             shape: RoundedRectangleBorder(
// // // // //                               borderRadius: BorderRadius.circular(15.0),
// // // // //                             ),
// // // // //                           ),
// // // // //                           onPressed: pauseTimer,
// // // // //                           child: Text('Pause',
// // // // //                               style: TextStyle(color: Colors.white)),
// // // // //                         ),
// // // // //                       ),
// // // // //                     if (_showContinueButton)
// // // // //                       Padding(
// // // // //                         padding: const EdgeInsets.symmetric(
// // // // //                             horizontal: 5, vertical: 10),
// // // // //                         child: ElevatedButton(
// // // // //                           style: ElevatedButton.styleFrom(
// // // // //                             backgroundColor: kprimarycolorpink,
// // // // //                             shape: RoundedRectangleBorder(
// // // // //                               borderRadius: BorderRadius.circular(15.0),
// // // // //                             ),
// // // // //                           ),
// // // // //                           onPressed: continueTimer,
// // // // //                           child: Text('Resume',
// // // // //                               style: TextStyle(color: Colors.white)),
// // // // //                         ),
// // // // //                       ),
// // // // //                     if (_isRunning || _showPauseButton || _showContinueButton)
// // // // //                       Padding(
// // // // //                         padding: const EdgeInsets.symmetric(
// // // // //                             horizontal: 5, vertical: 10),
// // // // //                         child: ElevatedButton(
// // // // //                           style: ElevatedButton.styleFrom(
// // // // //                             backgroundColor: kprimarycolorpink,
// // // // //                             shape: RoundedRectangleBorder(
// // // // //                               borderRadius: BorderRadius.circular(15.0),
// // // // //                             ),
// // // // //                           ),
// // // // //                           onPressed: restartTimer,
// // // // //                           child: Text('Cancel',
// // // // //                               style: TextStyle(color: Colors.white)),
// // // // //                         ),
// // // // //                       ),
// // // // //                   ],
// // // // //                 )
// // // // //               ],
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _timer?.cancel();
// // // // //     super.dispose();
// // // // //   }
// // // // // }


// // // // // Container(
// // // // //                           margin: EdgeInsets.symmetric(vertical: 10),
// // // // //                           padding: EdgeInsets.all(10),
// // // // //                           decoration: BoxDecoration(
// // // // //                             color: Colors.white,
// // // // //                             borderRadius: BorderRadius.circular(10),
// // // // //                             border: Border.all(color: Colors.grey[400]!),
// // // // //                           ),
// // // // //                           child: InkWell(
// // // // //                             onTap:
// // // // //                                 _showEditTimeDialog, // Makes the container clickable
// // // // //                             borderRadius: BorderRadius.circular(
// // // // //                                 30.0), // Rounded edges for ripple effect
// // // // //                             splashColor:
// // // // //                                 Colors.pink[50], // Splash color on click
// // // // //                             child: Container(
// // // // //                               width: 200,
// // // // //                               padding: EdgeInsets.symmetric(vertical: 10),
// // // // //                               decoration: BoxDecoration(
// // // // //                                 color: Colors.white,
// // // // //                                 borderRadius: BorderRadius.circular(30),
// // // // //                                 // boxShadow: [
// // // // //                                 //   BoxShadow(
// // // // //                                 //     color: Colors.grey.withOpacity(0.5),
// // // // //                                 //     spreadRadius: 2,
// // // // //                                 //     blurRadius: 5,
// // // // //                                 //     offset: Offset(0, 3),
// // // // //                                 //   ),
// // // // //                                 // ],
// // // // //                               ),
// // // // //                               child: Row(
// // // // //                                 mainAxisAlignment: MainAxisAlignment.center,
// // // // //                                 children: [
// // // // //                                   // Decrease Button
// // // // //                                   InkWell(
// // // // //                                     onTap: decreaseTime,
// // // // //                                     borderRadius: BorderRadius.circular(50),
// // // // //                                     child: Container(
// // // // //                                       padding: EdgeInsets.all(5),
// // // // //                                       decoration: BoxDecoration(
// // // // //                                         color: Colors.pink[50],
// // // // //                                         shape: BoxShape.circle,
// // // // //                                       ),
// // // // //                                       child: Icon(Icons.remove,
// // // // //                                           color: Colors.pink, size: 20),
// // // // //                                     ),
// // // // //                                   ),
// // // // //                                   // Timer Text
// // // // //                                   Padding(
// // // // //                                     padding: const EdgeInsets.symmetric(
// // // // //                                         horizontal: 10.0),
// // // // //                                     child: Text(
// // // // //                                       '$_timerDuration min',
// // // // //                                       style: TextStyle(
// // // // //                                           fontSize: 20, color: Colors.black),
// // // // //                                     ),
// // // // //                                   ),
// // // // //                                   // Increase Button
// // // // //                                   InkWell(
// // // // //                                     onTap: increaseTime,
// // // // //                                     borderRadius: BorderRadius.circular(50),
// // // // //                                     child: Container(
// // // // //                                       padding: EdgeInsets.all(5),
// // // // //                                       decoration: BoxDecoration(
// // // // //                                         color: Colors.pink[50],
// // // // //                                         shape: BoxShape.circle,
// // // // //                                       ),
// // // // //                                       child: Icon(Icons.add,
// // // // //                                           color: Colors.pink, size: 20),
// // // // //                                     ),
// // // // //                                   ),
// // // // //                                 ],
// // // // //                               ),
// // // // //                             ),
// // // // //                           )),
