import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color(0xFF3C8243)));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CustomizableTimer(),
  ));
}

class CustomizableTimer extends StatefulWidget {
  @override
  _CustomizableTimerState createState() => _CustomizableTimerState();
}

class _CustomizableTimerState extends State<CustomizableTimer> {
  int _timerDuration = 1; // Default duration in minutes
  String _timerText = '00:00';
  int _remainingSeconds = 0;
  bool _isRunning = false;
  bool _showPauseButton = false;
  bool _showContinueButton = false;
  Timer? _timer;

  void startTimer(int minutes) {
    int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
          int minutes = seconds ~/ 60;
          int remainingSeconds = seconds % 60;
          _timerText =
              '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
          _remainingSeconds = seconds;
        } else {
          _timer?.cancel();
          _isRunning = false;
          _showPauseButton = false;
          _showContinueButton = false;
        }
      });
    });
    _isRunning = true;
    _showPauseButton = true;
    _showContinueButton = false;
  }

  void pauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
      _showPauseButton = false;
      _showContinueButton = true;
    }
    setState(() {});
  }

  void restartTimer() {
    pauseTimer();
    setState(() {
      _remainingSeconds = 0;
      _timerText = '$_timerDuration:00';
      _showPauseButton = false;
      _showContinueButton = false;
    });
  }

  void continueTimer() {
    if (!_isRunning) {
      _isRunning = true;
      startTimer(_remainingSeconds ~/ 60);
      _showPauseButton = true;
      _showContinueButton = false;
    }
    setState(() {});
  }

  void increaseTime() {
    setState(() {
      _timerDuration++;
      _timerText = '$_timerDuration:00';
    });
  }

  void decreaseTime() {
    if (_timerDuration > 1) {
      setState(() {
        _timerDuration--;
        _timerText = '$_timerDuration:00';
      });
    }
  }

  Future<void> _showEditTimeDialog() async {
    TextEditingController controller =
        TextEditingController(text: _timerDuration.toString());

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Timer Duration'),
          content: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter time in minutes',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.pink)),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  int newValue = int.parse(controller.text);
                  if (newValue > 0) {
                    setState(() {
                      _timerDuration = newValue;
                      restartTimer();
                    });
                    Navigator.pop(context);
                  }
                }
              },
              child: Text('OK', style: TextStyle(color: Colors.pink)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: 200,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        value: _isRunning
                            ? 1 - (_remainingSeconds / (_timerDuration * 60.0))
                            : 0,
                        backgroundColor: Colors.grey[300],
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                        strokeWidth: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Optional: Add timer click functionality if needed
                      },
                      child: Text(
                        _timerText,
                        style: TextStyle(fontSize: 30, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(height: 10),
                if (!_isRunning && !_showPauseButton && !_showContinueButton)
                  Column(
                    children: [
                      
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [ ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: _showEditTimeDialog,
                  child: Text('Set Timer', style: TextStyle(color: Colors.white)),
                ),SizedBox(width: 20,),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            onPressed: () {
                              if (!_isRunning) {
                                startTimer(_timerDuration);
                              }
                            },
                            child: Text('Start',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                if (_showPauseButton)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onPressed: pauseTimer,
                      child:
                          Text('Pause', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                if (_showContinueButton)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onPressed: continueTimer,
                      child: Text('Continue',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                if (_isRunning || _showPauseButton || _showContinueButton)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onPressed: restartTimer,
                      child: Text('Cancel Timer',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}


// Container(
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: Colors.grey[400]!),
//                           ),
//                           child: InkWell(
//                             onTap:
//                                 _showEditTimeDialog, // Makes the container clickable
//                             borderRadius: BorderRadius.circular(
//                                 30.0), // Rounded edges for ripple effect
//                             splashColor:
//                                 Colors.pink[50], // Splash color on click
//                             child: Container(
//                               width: 200,
//                               padding: EdgeInsets.symmetric(vertical: 10),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(30),
//                                 // boxShadow: [
//                                 //   BoxShadow(
//                                 //     color: Colors.grey.withOpacity(0.5),
//                                 //     spreadRadius: 2,
//                                 //     blurRadius: 5,
//                                 //     offset: Offset(0, 3),
//                                 //   ),
//                                 // ],
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   // Decrease Button
//                                   InkWell(
//                                     onTap: decreaseTime,
//                                     borderRadius: BorderRadius.circular(50),
//                                     child: Container(
//                                       padding: EdgeInsets.all(5),
//                                       decoration: BoxDecoration(
//                                         color: Colors.pink[50],
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: Icon(Icons.remove,
//                                           color: Colors.pink, size: 20),
//                                     ),
//                                   ),
//                                   // Timer Text
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10.0),
//                                     child: Text(
//                                       '$_timerDuration min',
//                                       style: TextStyle(
//                                           fontSize: 20, color: Colors.black),
//                                     ),
//                                   ),
//                                   // Increase Button
//                                   InkWell(
//                                     onTap: increaseTime,
//                                     borderRadius: BorderRadius.circular(50),
//                                     child: Container(
//                                       padding: EdgeInsets.all(5),
//                                       decoration: BoxDecoration(
//                                         color: Colors.pink[50],
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: Icon(Icons.add,
//                                           color: Colors.pink, size: 20),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )),
