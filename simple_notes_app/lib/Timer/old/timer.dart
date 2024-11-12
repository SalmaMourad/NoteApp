// old timer working but no navigation
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:simple_notes_app/constants.dart';

// void main() {
//   SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(statusBarColor: Color(0xFF3C8243)));
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: CustomizableTimer(),
//   ));
// }

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

//     await showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Set Timer Duration'),
//           content: TextFormField(
//             controller: controller,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               labelText: 'Enter time in minutes',
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel', style: TextStyle(color: kprimarycolorpink)),
//             ),
//             TextButton(
//               onPressed: () {
//                 if (controller.text.isNotEmpty) {
//                   int newValue = int.parse(controller.text);
//                   if (newValue > 0) {
//                     setState(() {
//                       _timerDuration = newValue;
//                       restartTimer();
//                     });
//                     Navigator.pop(context);
//                   }
//                 }
//               },
//               child: Text('OK', style: TextStyle(color: kprimarycolorpink)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: ListView(
//           children: [
//             SizedBox(
//               height: 200,
//             ),
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
//                             AlwaysStoppedAnimation<Color>(kprimarycolorpink),
//                         strokeWidth: 10,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         // Optional: Add timer click functionality if needed
//                       },
//                       child: Text(
//                         _timerText,
//                         style: TextStyle(fontSize: 30, color: Colors.grey),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 SizedBox(height: 10),
//                 if (!_isRunning && !_showPauseButton && !_showContinueButton)
//                   Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: kprimarycolorpink,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15.0),
//                               ),
//                             ),
//                             onPressed: _showEditTimeDialog,
//                             child: Text('Set Timer',
//                                 style: TextStyle(color: Colors.white)),
//                           ),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: kprimarycolorpink,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15.0),
//                               ),
//                             ),
//                             onPressed: () {
//                               if (!_isRunning) {
//                                 startTimer(_timerDuration);
//                               }
//                             },
//                             child: Text('Start',
//                                 style: TextStyle(color: Colors.white)),
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
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 5, vertical: 10),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: kprimarycolorpink,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                           ),
//                           onPressed: pauseTimer,
//                           child: Text('Pause',
//                               style: TextStyle(color: Colors.white)),
//                         ),
//                       ),
//                     if (_showContinueButton)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 5, vertical: 10),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: kprimarycolorpink,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                           ),
//                           onPressed: continueTimer,
//                           child: Text('Resume',
//                               style: TextStyle(color: Colors.white)),
//                         ),
//                       ),
//                     if (_isRunning || _showPauseButton || _showContinueButton)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 5, vertical: 10),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: kprimarycolorpink,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                           ),
//                           onPressed: restartTimer,
//                           child: Text('Cancel',
//                               style: TextStyle(color: Colors.white)),
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
