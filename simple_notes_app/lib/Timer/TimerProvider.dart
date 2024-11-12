import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/Timer/swwwwwwwwwww.dart';

import 'package:flutter/material.dart';
import 'dart:async';

class TimerProvider extends ChangeNotifier {
  int _timerDuration = 1; // Default duration in minutes
  String _timerText = '1:00'; // Default timer display
  int _remainingSeconds = 0;
  bool _isRunning = false;
  bool _showPauseButton = false;
  bool _showContinueButton = false;
  Timer? _timer;

  // Getter for timer duration
  int get timerDuration => _timerDuration;

  // Getter for timer text
  String get timerText => _timerText;

  // Getter for isRunning
  bool get isRunning => _isRunning;

  // Getter for remaining seconds (used for the progress indicator)
  int get remainingSeconds => _remainingSeconds;

  // Getter for showPauseButton
  bool get showPauseButton => _showPauseButton;

  // Getter for showContinueButton
  bool get showContinueButton => _showContinueButton;

  // Start the timer with the given duration in minutes
  void startTimer(int minutes) {
    int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        int minutes = seconds ~/ 60;
        int remainingSeconds = seconds % 60;
        _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
        _remainingSeconds = seconds;
        notifyListeners();
      } else {
        _stopTimer();
      }
    });
    _isRunning = true;
    _showPauseButton = true;
    _showContinueButton = false;
    notifyListeners();
  }

  // Pause the timer
  void pauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
      _showPauseButton = false;
      _showContinueButton = true;
      notifyListeners();
    }
  }

  // Restart the timer
  void restartTimer() {
    pauseTimer();
    _remainingSeconds = 0;
    _timerText = '$_timerDuration:00';
    _showPauseButton = false;
    _showContinueButton = false;
    notifyListeners();
  }

  // Continue the timer after pausing
  void continueTimer() {
    if (!_isRunning) {
      startTimer(_remainingSeconds ~/ 60);
    }
  }

  // Set the timer duration and restart
  void setTimerDuration(int newDuration) {
    _timerDuration = newDuration;
    _timerText = '$_timerDuration:00';
    restartTimer();
  }

  // Stop the timer completely
  void _stopTimer() {
    _timer?.cancel();
    _isRunning = false;
    _showPauseButton = false;
    _showContinueButton = false;
    notifyListeners();
  }
}

// class TimerProvider extends ChangeNotifier {
//   int _timerDuration = 1; // Default duration in minutes
//   String _timerText = '1:00'; // Default timer display
//   int _remainingSeconds = 0;
//   bool _isRunning = false;
//   Timer? _timer;

//   // Getter for _timerDuration
//   int get timerDuration => _timerDuration;

//   // Getter for timerText
//   String get timerText => _timerText;

//   // Getter for isRunning
//   bool get isRunning => _isRunning;

//   // Getter for remainingSeconds
//   int get remainingSeconds => _remainingSeconds;

//   // Start the timer
//   void startTimer(int minutes) {
//     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (seconds > 0) {
//         seconds--;
//         int minutes = seconds ~/ 60;
//         int remainingSeconds = seconds % 60;
//         _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
//         _remainingSeconds = seconds;
//         notifyListeners();
//       } else {
//         _timer?.cancel();
//         _isRunning = false;
//         notifyListeners();
//       }
//     });
//     _isRunning = true;
//     notifyListeners();
//   }

//   // Pause the timer
//   void pauseTimer() {
//     _timer?.cancel();
//     _isRunning = false;
//     notifyListeners();
//   }

//   // Restart the timer
//   void restartTimer() {
//     pauseTimer();
//     _remainingSeconds = 0;
//     _timerText = '$_timerDuration:00';
//     notifyListeners();
//   }

//   // Set the timer duration
//   void setTimerDuration(int newDuration) {
//     _timerDuration = newDuration;
//     _timerText = '$_timerDuration:00';
//     notifyListeners();
//   }

//   // Continue the timer after pausing
//   void continueTimer() {
//     startTimer(_remainingSeconds ~/ 60);
//     notifyListeners();
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'timer_provider.dart'; // Ensure the correct import path

class Widget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: timerProvider.isRunning
                      ? 1 -
                          (timerProvider.remainingSeconds /
                              (timerProvider.timerDuration * 60.0))
                      : 0,
                  backgroundColor: Colors.grey[100],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                  strokeWidth: 10,
                ),
              ),
              Text(
                timerProvider.timerText,
                style: TextStyle(fontSize: 40, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 20),
          if (!timerProvider.isRunning &&
              !timerProvider.showPauseButton &&
              !timerProvider.showContinueButton)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            TextEditingController controller =
                                TextEditingController(
                                    text:
                                        timerProvider.timerDuration.toString());
                            return AlertDialog(
                              title: Text('Set Timer Duration'),
                              content: TextFormField(
                                controller: controller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Enter time in minutes',
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    int newDuration =
                                        int.parse(controller.text);
                                    if (newDuration > 0) {
                                      timerProvider
                                          .setTimerDuration(newDuration);
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Set Timer'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        timerProvider.startTimer(timerProvider.timerDuration);
                      },
                      child: Text('Start Timer'),
                    ),
                  ],
                ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (timerProvider.showPauseButton)
                ElevatedButton(
                  onPressed: timerProvider.pauseTimer,
                  child: Text('Pause'),
                ),
              if (timerProvider.showContinueButton)
                ElevatedButton(
                  onPressed: timerProvider.continueTimer,
                  child: Text('Resume'),
                ),
              if (timerProvider.isRunning ||
                  timerProvider.showPauseButton ||
                  timerProvider.showContinueButton)
                ElevatedButton(
                  onPressed: timerProvider.restartTimer,
                  child: Text('Cancel'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// class Widget1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final timerProvider = Provider.of<TimerProvider>(context);

//     return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   width: 200,
//                   height: 200,
//                   child: CircularProgressIndicator(
//                     value: timerProvider.isRunning
//                         ? 1 - (timerProvider.remainingSeconds /
//                             (timerProvider.timerDuration * 60.0))
//                         : 0,
//                     backgroundColor: Colors.grey[100],
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
//                     strokeWidth: 10,
//                   ),
//                 ),
//                 Text(
//                   timerProvider.timerText,
//                   style: TextStyle(fontSize: 40, color: Colors.grey),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             if (!timerProvider.isRunning)
//               ElevatedButton(
//                 onPressed: () {
//                   timerProvider.startTimer(timerProvider.timerDuration);
//                 },
//                 child: Text('Start Timer'),
//               ),
//             if (timerProvider.isRunning)
//               ElevatedButton(
//                 onPressed: timerProvider.pauseTimer,
//                 child: Text('Pause Timer'),
//               ),
//             ElevatedButton(
//               onPressed: timerProvider.restartTimer,
//               child: Text('Restart Timer'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to another screen
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => OtherScreen()),
//                 );
//               },
//               child: Text('Go to Another Screen'),
//             ),
//           ],
//         ),
     
//     );
//   }
// }

// class TimerProvider extends ChangeNotifier {
//   int _timerDuration = 1; // Default duration in minutes
//   String _timerText = '1:00'; // Default timer display
//   int _remainingSeconds = 0;
//   bool _isRunning = false;
//   Timer? _timer;

//   // Getters for state
//   String get timerText => _timerText;
//   bool get isRunning => _isRunning;
//   int get remainingSeconds => _remainingSeconds;

//   // Start the timer
//   void startTimer(int minutes) {
//     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (seconds > 0) {
//         seconds--;
//         int minutes = seconds ~/ 60;
//         int remainingSeconds = seconds % 60;
//         _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
//         _remainingSeconds = seconds;
//         notifyListeners();
//       } else {
//         _timer?.cancel();
//         _isRunning = false;
//         notifyListeners();
//       }
//     });
//     _isRunning = true;
//     notifyListeners();
//   }

//   // Pause the timer
//   void pauseTimer() {
//     _timer?.cancel();
//     _isRunning = false;
//     notifyListeners();
//   }

//   // Restart the timer
//   void restartTimer() {
//     pauseTimer();
//     _remainingSeconds = 0;
//     _timerText = '$_timerDuration:00';
//     notifyListeners();
//   }

//   // Set the timer duration
//   void setTimerDuration(int newDuration) {
//     _timerDuration = newDuration;
//     _timerText = '$_timerDuration:00';
//     notifyListeners();
//   }

//   // Continue the timer after pausing
//   void continueTimer() {
//     startTimer(_remainingSeconds ~/ 60);
//     notifyListeners();
//   }
// }
