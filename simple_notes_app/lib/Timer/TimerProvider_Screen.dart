import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/constants.dart';

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

  String get timerText => _timerText;

  bool get isRunning => _isRunning;

  int get remainingSeconds => _remainingSeconds;

  bool get showPauseButton => _showPauseButton;

  bool get showContinueButton => _showContinueButton;

  void startTimer(int minutes) {
    int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

  void pauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
      _showPauseButton = false;
      _showContinueButton = true;
      notifyListeners();
    }
  }

  void restartTimer() {
    pauseTimer();
    _remainingSeconds = 0;
    _timerText = '$_timerDuration:00';
    _showPauseButton = false;
    _showContinueButton = false;
    notifyListeners();
  }

  void continueTimer() {
    if (!_isRunning) {
      startTimer(_remainingSeconds ~/ 60);
    }
  }

  void setTimerDuration(int newDuration) {
    _timerDuration = newDuration;
    _timerText = '$_timerDuration:00';
    restartTimer();
  }

  void _stopTimer() {
    _timer?.cancel();
    _isRunning = false;
    _showPauseButton = false;
    _showContinueButton = false;
    notifyListeners();
  }
}

class TimerScreen extends StatelessWidget {
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
                  backgroundColor: Color.fromARGB(255, 255, 229, 229),
                  valueColor: AlwaysStoppedAnimation<Color>(kprimarycolorpink),
                  strokeWidth: 10,
                ),
              ),
              Text(
                timerProvider.timerText,
                style: const TextStyle(fontSize: 40, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),
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
                              title: const Text('Set Timer Duration'),
                              content: TextFormField(
                                controller: controller,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Enter time in minutes',
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: kprimarycolorpink),
                                  ),
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
                                  child: Text(
                                    'OK',
                                    style: TextStyle(color: kprimarycolorpink),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'Set Timer',
                        style: TextStyle(color: kprimarycolorpink),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        timerProvider.startTimer(timerProvider.timerDuration);
                      },
                      child: Text(
                        'Start Timer',
                        style: TextStyle(color: kprimarycolorpink),
                      ),
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
                  child: Text(
                    'Pause',
                    style: TextStyle(color: kprimarycolorpink),
                  ),
                ),
              if (timerProvider.showContinueButton)
                ElevatedButton(
                  onPressed: timerProvider.continueTimer,
                  child: Text(
                    'Resume',
                    style: TextStyle(color: kprimarycolorpink),
                  ),
                ),
              SizedBox(
                width: 15,
              ),
              if (timerProvider.isRunning ||
                  timerProvider.showPauseButton ||
                  timerProvider.showContinueButton)
                ElevatedButton(
                  onPressed: timerProvider.restartTimer,
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: kprimarycolorpink),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
