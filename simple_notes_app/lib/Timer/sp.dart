import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchProvider extends ChangeNotifier {
  late Timer _timer;
  int _elapsedTime = 0;
  int _previousLapTime = 0;
  bool _isRunning = false;
  List<String> _laps = [];
  List<String> _lapDifferences = [];

  int get elapsedTime => _elapsedTime;
  bool get isRunning => _isRunning;
  List<String> get laps => _laps;
  List<String> get lapDifferences => _lapDifferences;

  // Start the stopwatch
  void startStopwatch() {
    if (_isRunning) return;

    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _elapsedTime++;
      notifyListeners(); // Notify listeners when time changes
    });
  }

  // Stop the stopwatch
  void stopStopwatch() {
    _isRunning = false;
    _timer.cancel();
    notifyListeners();
  }

  // Reset the stopwatch
  void resetStopwatch() {
    _elapsedTime = 0;
    _laps.clear();
    _lapDifferences.clear();
    _previousLapTime = 0;
    notifyListeners();
  }

  // Record a lap
  void recordLap() {
    int currentLapTime = _elapsedTime;
    int lapDifference = currentLapTime - _previousLapTime;

    _laps.add(formatTime(currentLapTime));
    _lapDifferences.add(formatTime(lapDifference));

    _previousLapTime = currentLapTime;
    notifyListeners(); // Notify listeners after recording a lap
  }

  // Format time into MM:SS format
  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';

// class StopwatchProvider extends ChangeNotifier {
//   late Timer _timer;
//   int _elapsedTime = 0;
//   int _previousLapTime = 0;
//   bool _isRunning = false;
//   List<String> _laps = [];
//   List<String> _lapDifferences = [];

//   int get elapsedTime => _elapsedTime;
//   bool get isRunning => _isRunning;
//   List<String> get laps => _laps;
//   List<String> get lapDifferences => _lapDifferences;

//   // Start the stopwatch
//   void startStopwatch() {
//     if (_isRunning) return;

//     _isRunning = true;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       _elapsedTime++;
//       notifyListeners(); // Notify listeners when time changes
//     });
//   }

//   // Stop the stopwatch
//   void stopStopwatch() {
//     _isRunning = false;
//     _timer.cancel();
//     notifyListeners();
//   }

//   // Reset the stopwatch
//   void resetStopwatch() {
//     _elapsedTime = 0;
//     _laps.clear();
//     _lapDifferences.clear();
//     _previousLapTime = 0;
//     notifyListeners();
//   }

//   // Record a lap
//   void recordLap() {
//     int currentLapTime = _elapsedTime;
//     int lapDifference = currentLapTime - _previousLapTime;

//     _laps.add(_formatTime(currentLapTime));
//     _lapDifferences.add(_formatTime(lapDifference));

//     _previousLapTime = currentLapTime;
//     notifyListeners(); // Notify listeners after recording a lap
//   }

//   String _formatTime(int seconds) {
//     int minutes = seconds ~/ 60;
//     int remainingSeconds = seconds % 60;
//     return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
//   }
// }
