import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/Timer/TimerProvider.dart';
import 'package:simple_notes_app/Timer/sp.dart';
import 'package:simple_notes_app/Timer/swwwwwwwwwww.dart';
import 'package:simple_notes_app/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TimerProvider(),
          // child: MyApp(),
        ),
        //  ChangeNotifierProvider(create: (_) => StopwatchProvider()),
        ChangeNotifierProvider(
          create: (_) => StopwatchProvider(),
          child: CustomizableStopwatch(),
        )

        // child: MaterialApp(
        //   title: 'Flutter Stopwatch App',
        //   theme: ThemeData(
        //     primarySwatch: Colors.blue,
        //   ),
        //   initialRoute: '/',
        //   routes: {
        //     '/': (context) => StopwatchScreen(),
        //     '/otherScreen': (context) => OtherScreen(),
        //   },
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ToggleWidgetsScreen(),
        //  routes: {
        //   '/stopwatch': (context) => CustomizableStopwatch(), // Set a route for the stopwatch screen
        // },
      ),
    );
  }
}

class ToggleWidgetsScreen extends StatefulWidget {
  @override
  _ToggleWidgetsScreenState createState() => _ToggleWidgetsScreenState();
}

class _ToggleWidgetsScreenState extends State<ToggleWidgetsScreen> {
  bool isWidget1Selected = true;

  void toggleWidgets() {
    setState(() {
      isWidget1Selected = !isWidget1Selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Toggle Between Widgets'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Toggle Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 110,
              ),
              ElevatedButton(
                onPressed: toggleWidgets,
                child: Text('Timer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isWidget1Selected
                      ? kprimarycolorpink
                      : Colors.grey.shade50,
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: toggleWidgets,
                child: Text('Stop Watch'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: !isWidget1Selected
                      ? kprimarycolorpink
                      : Colors.grey.shade50,
                ),
              ),
            ],
          ),
          Spacer(
            flex: 1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              // Conditional Rendering of Widgets
              isWidget1Selected ? Widget1() : CustomizableStopwatch(),
            ],
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}

// class Widget1 extends StatefulWidget {
//   @override
//   State<Widget1> createState() => _Widget1State();
// }

// class _Widget1State extends State<Widget1> {  int _timerDuration = 1; // Default duration in minutes
//   String _timerText = '1:00'; // Default timer display
//   int _remainingSeconds = 0;
//   bool _isRunning = false;
//   bool _showPauseButton = false;
//   bool _showContinueButton = false;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     // Ensure the timer updates correctly after the widget is laid out
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       setState(() {});
//     });
//   }

//   void startTimer(int minutes) {
//     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (seconds > 0) {
//           seconds--;
//           int minutes = seconds ~/ 60;
//           int remainingSeconds = seconds % 60;
//           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
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
//             child: Text('Cancel', style: TextStyle(color: kprimarycolorpink)),
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
//             child: Text('OK', style: TextStyle(color: kprimarycolorpink)),
//           ),
//         ],
//       );
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: 30),
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   width: 200,
//                   height: 200,
//                   child: CircularProgressIndicator(
//                     value: _isRunning
//                         ? 1 - (_remainingSeconds / (_timerDuration * 60.0))
//                         : 0,
//                     backgroundColor: Colors.grey[100],
//                     valueColor:
//                         AlwaysStoppedAnimation<Color>(kprimarycolorpink),
//                     strokeWidth: 10,
//                   ),
//                 ),
//                 Text(
//                   _timerText,
//                   style: TextStyle(fontSize: 40, color: Colors.grey),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             if (!_isRunning && !_showPauseButton && !_showContinueButton)
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: kprimarycolorpink,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15.0),
//                           ),
//                         ),
//                         onPressed: _showEditTimeDialog,
//                         child: Text('Set Timer',
//                             style: TextStyle(color: Colors.white)),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: kprimarycolorpink,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15.0),
//                           ),
//                         ),
//                         onPressed: () {
//                           if (!_isRunning) {
//                             startTimer(_timerDuration);
//                           }
//                         },
//                         child: Text('Start',
//                             style: TextStyle(color: Colors.white)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (_showPauseButton)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 5, vertical: 10),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: kprimarycolorpink,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                       ),
//                       onPressed: pauseTimer,
//                       child: Text('Pause',
//                           style: TextStyle(color: Colors.white)),
//                     ),
//                   ),
//                 if (_showContinueButton)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 5, vertical: 10),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: kprimarycolorpink,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                       ),
//                       onPressed: continueTimer,
//                       child: Text('Resume',
//                           style: TextStyle(color: Colors.white)),
//                     ),
//                   ),
//                 if (_isRunning || _showPauseButton || _showContinueButton)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 5, vertical: 10),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: kprimarycolorpink,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                       ),
//                       onPressed: restartTimer,
//                       child: Text('Cancel',
//                           style: TextStyle(color: Colors.white)),
//                     ),
//                   ),
//               ],
//             )
//           ],
//         ),
//       );
//   }
// }

class Widget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      width: 200,
      height: 200,
      child: Center(
        child: Text('Widget 2', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}


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
//     return 
//        Center(
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
      
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:simple_notes_app/Timer/timer%20copy.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TogglePage(),
//     );
//   }
// }

// class TogglePage extends StatefulWidget {
//   @override
//   _TogglePageState createState() => _TogglePageState();
// }

// class _TogglePageState extends State<TogglePage> {
//   bool _isFirstWidget = true;

//   void _toggleWidget(bool isFirst) {
//     setState(() {
//       _isFirstWidget = isFirst;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Toggle Between Widgets'),
//       ),
//       body: Center(
//         child: ListView(
//           children:[ Column(
//             // mainAxisAlignment: MainAxisAlignment.,
//             children: [
//               // Two toggle buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => _toggleWidget(true),
//                     child: Text('Widget 1'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: _isFirstWidget ? Colors.blue : Colors.grey, // Highlight the active button
//                     ),
//                   ),
//                   SizedBox(width: 20),
//                   ElevatedButton(
//                     onPressed: () => _toggleWidget(false),
//                     child: Text('Widget 2'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: !_isFirstWidget ? Colors.green : Colors.grey, // Highlight the active button
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               // Conditional widget display based on _isFirstWidget
//               _isFirstWidget ? CustomizableTimer() : SecondWidget(),
//             ],
//           ),
//         ],),
//       ),
//     );
//   }
// }

// class FirstWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(20),
//       color: Colors.blue,
//       child: Text(
//         'This is the First Widget',
//         style: TextStyle(fontSize: 24, color: Colors.white),
//       ),
//     );
//   }
// }

// class SecondWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(20),
//       color: Colors.green,
//       child: Text(
//         'This is the Second Widget',
//         style: TextStyle(fontSize: 24, color: Colors.white),
//       ),
//     );
//   }
// }
