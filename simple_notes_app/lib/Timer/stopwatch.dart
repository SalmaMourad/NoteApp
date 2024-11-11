// customizable_stopwatch.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:simple_notes_app/constants.dart';

class CustomizableStopwatch extends StatefulWidget {
  @override
  _CustomizableStopwatchState createState() => _CustomizableStopwatchState();
}

class _CustomizableStopwatchState extends State<CustomizableStopwatch> {
  int _elapsedSeconds = 0;
  bool _isRunning = false;
  Timer? _stopwatchTimer;

  String get _formattedTime {
    int minutes = _elapsedSeconds ~/ 60;
    int seconds = _elapsedSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void startStopwatch() {
    _stopwatchTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
    setState(() {
      _isRunning = true;
    });
  }

  void stopStopwatch() {
    _stopwatchTimer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void resetStopwatch() {
    stopStopwatch();
    setState(() {
      _elapsedSeconds = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: _isRunning ? _elapsedSeconds / 600 : 0,
                backgroundColor: Colors.grey[100],
                valueColor: AlwaysStoppedAnimation<Color>(kprimarycolorpink),
                strokeWidth: 10,
              ),
            ),
            Text(
              _formattedTime,
              style: TextStyle(fontSize: 30, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isRunning)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kprimarycolorpink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: startStopwatch,
                child: Text('Start', style: TextStyle(color: Colors.white)),
              ),
            if (_isRunning)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kprimarycolorpink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: stopStopwatch,
                child: Text('Stop', style: TextStyle(color: Colors.white)),
              ),
            SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kprimarycolorpink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onPressed: resetStopwatch,
              child: Text('Reset', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _stopwatchTimer?.cancel();
    super.dispose();
  }
}

// // customizable_stopwatch.dart
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:simple_notes_app/constants.dart';

// class CustomizableStopwatch extends StatefulWidget {
//   @override
//   _CustomizableStopwatchState createState() => _CustomizableStopwatchState();
// }

// class _CustomizableStopwatchState extends State<CustomizableStopwatch> {
//   int _elapsedSeconds = 0;
//   bool _isRunning = false;
//   Timer? _stopwatchTimer;

//   String get _formattedTime {
//     int minutes = _elapsedSeconds ~/ 60;
//     int seconds = _elapsedSeconds % 60;
//     return '$minutes:${seconds.toString().padLeft(2, '0')}';
//   }

//   void startStopwatch() {
//     _stopwatchTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         _elapsedSeconds++;
//       });
//     });
//     setState(() {
//       _isRunning = true;
//     });
//   }

//   void stopStopwatch() {
//     _stopwatchTimer?.cancel();
//     setState(() {
//       _isRunning = false;
//     });
//   }

//   void resetStopwatch() {
//     stopStopwatch();
//     setState(() {
//       _elapsedSeconds = 0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Stack(
//           alignment: Alignment.center,
//           children: [
//             SizedBox(
//               width: 200,
//               height: 200,
//               child: CircularProgressIndicator(
//                 value: _isRunning ? _elapsedSeconds / 600 : 0,
//                 backgroundColor: Colors.grey[100],
//                 valueColor: AlwaysStoppedAnimation<Color>(kprimarycolorpink),
//                 strokeWidth: 10,
//               ),
//             ),
//             Text(
//               _formattedTime,
//               style: TextStyle(fontSize: 30, color: Colors.grey),
//             ),
//           ],
//         ),
//         SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (!_isRunning)
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: kprimarycolorpink,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.0),
//                   ),
//                 ),
//                 onPressed: startStopwatch,
//                 child: Text('Start', style: TextStyle(color: Colors.white)),
//               ),
//             if (_isRunning)
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: kprimarycolorpink,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.0),
//                   ),
//                 ),
//                 onPressed: stopStopwatch,
//                 child: Text('Stop', style: TextStyle(color: Colors.white)),
//               ),
//             SizedBox(width: 10),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: kprimarycolorpink,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//               ),
//               onPressed: resetStopwatch,
//               child: Text('Reset', style: TextStyle(color: Colors.white)),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _stopwatchTimer?.cancel();
//     super.dispose();
//   }
// }
