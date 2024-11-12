import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/Timer/sp.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: StopwatchScreen(),
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'stopwatch_provider.dart'; // Import the StopwatchProvider

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => StopwatchProvider(),
//       child: MaterialApp(
//         title: 'Flutter Stopwatch App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         initialRoute: '/',
//         routes: {
//           '/': (context) => CustomizableStopwatch(),
//           '/otherScreen': (context) => OtherScreen(),
//         },
//       ),
//     );
//   }
// }

class CustomizableStopwatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing the StopwatchProvider
    var stopwatchProvider = Provider.of<StopwatchProvider>(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Timer display and buttons
          Text(
            stopwatchProvider.formatTime(stopwatchProvider.elapsedTime),
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: stopwatchProvider.isRunning
                    ? null
                    : stopwatchProvider.startStopwatch,
                child: Text("Start"),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: !stopwatchProvider.isRunning &&
                        stopwatchProvider.elapsedTime == 0
                    ? null
                    : stopwatchProvider.stopStopwatch,
                child: Text("Stop"),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: stopwatchProvider.resetStopwatch,
                child: Text("Reset"),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: stopwatchProvider.isRunning
                ? stopwatchProvider.recordLap
                : null,
            child: Text("Lap"),
          ),
          SizedBox(height: 20),

          // List of laps
          ListView.builder(
            shrinkWrap: true, // Allow ListView to take only the necessary space
            physics:
                NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
            itemCount: stopwatchProvider.laps.length,
            itemBuilder: (context, index) {
              return ListTile(
                title:
                    Text("Lap ${index + 1}: ${stopwatchProvider.laps[index]}"),
                subtitle: Text(
                    "Lap Time: ${stopwatchProvider.lapDifferences[index]}"),
              );
            },
          ),
        ],
      ),
    );

    // SingleChildScrollView(
    //   child: Container(height: 300,
    //     child: Column(
    //       // mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(
    //           stopwatchProvider.formatTime(stopwatchProvider.elapsedTime),
    //           style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
    //         ),
    //         SizedBox(height: 20),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             ElevatedButton(
    //               onPressed: stopwatchProvider.isRunning ? null : stopwatchProvider.startStopwatch,
    //               child: Text("Start"),
    //             ),
    //             SizedBox(width: 20),
    //             ElevatedButton(
    //               onPressed: !stopwatchProvider.isRunning && stopwatchProvider.elapsedTime == 0
    //                   ? null
    //                   : stopwatchProvider.stopStopwatch,
    //               child: Text("Stop"),
    //             ),
    //             SizedBox(width: 20),
    //             ElevatedButton(
    //               onPressed: stopwatchProvider.resetStopwatch,
    //               child: Text("Reset"),
    //             ),
    //           ],
    //         ),
    //         SizedBox(height: 20),
    //         ElevatedButton(
    //           onPressed: stopwatchProvider.isRunning ? stopwatchProvider.recordLap : null,
    //           child: Text("Lap"),
    //         ),
    //         SizedBox(height: 20),
    //         Expanded(
    //           child: ListView.builder(
    //             itemCount: stopwatchProvider.laps.length,
    //             itemBuilder: (context, index) {
    //               return ListTile(
    //                 title: Text("Lap ${index + 1}: ${stopwatchProvider.laps[index]}"),
    //                 subtitle: Text("Lap Time: ${stopwatchProvider.lapDifferences[index]}"),
    //               );
    //             },
    //           ),
    //         ),
    //         // ElevatedButton(
    //         //   onPressed: () {
    //         //     Navigator.pushNamed(context, '/otherScreen');
    //         //   },
    //         //   child: Text("Go to Other Screen"),
    //         // ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

// class OtherScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Other Screen"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context); // Go back to the stopwatch screen
//           },
//           child: Text("Back to Stopwatch Screen"),
//         ),
//       ),
//     );
//   }
// }



// class StopwatchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Accessing the StopwatchProvider
//     var stopwatchProvider = Provider.of<StopwatchProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Stopwatch with Laps"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               stopwatchProvider.formatTime(stopwatchProvider.elapsedTime),
//               style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: stopwatchProvider.isRunning ? null : stopwatchProvider.startStopwatch,
//                   child: Text("Start"),
//                 ),
//                 SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: !stopwatchProvider.isRunning && stopwatchProvider.elapsedTime == 0
//                       ? null
//                       : stopwatchProvider.stopStopwatch,
//                   child: Text("Stop"),
//                 ),
//                 SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: stopwatchProvider.resetStopwatch,
//                   child: Text("Reset"),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: stopwatchProvider.isRunning ? stopwatchProvider.recordLap : null,
//               child: Text("Lap"),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: stopwatchProvider.laps.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text("Lap ${index + 1}: ${stopwatchProvider.laps[index]}"),
//                     subtitle: Text("Lap Time: ${stopwatchProvider.lapDifferences[index]}"),
//                   );
//                 },
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/otherScreen');
//               },
//               child: Text("Go to Other Screen"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





// class StopwatchScreen extends StatefulWidget {
//   @override
//   _StopwatchScreenState createState() => _StopwatchScreenState();
// }

// class _StopwatchScreenState extends State<StopwatchScreen> {
//   late Timer _timer;
//   int _elapsedTime = 0; // Total elapsed time in seconds
//   int _previousLapTime = 0; // Time of the previous lap in seconds
//   bool _isRunning = false;
//   List<String> _laps = []; // List to store lap times
//   List<String> _lapDifferences = []; // List to store lap time differences

//   void _startStopwatch() {
//     setState(() {
//       _isRunning = true;
//     });
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         _elapsedTime++;
//       });
//     });
//   }

//   void _stopStopwatch() {
//     setState(() {
//       _isRunning = false;
//     });
//     _timer.cancel();
//   }

//   void _resetStopwatch() {
//     setState(() {
//       _elapsedTime = 0;
//       _laps.clear(); // Clear laps
//       _lapDifferences.clear(); // Clear lap differences
//       _previousLapTime = 0; // Reset previous lap time
//     });
//   }

//   void _recordLap() {
//     int currentLapTime = _elapsedTime;
//     setState(() {
//       // Calculate the difference between the current lap and the previous lap
//       int lapDifference = currentLapTime - _previousLapTime;

//       // Store the lap time
//       _laps.add(_formatTime(currentLapTime));

//       // Store the lap difference
//       _lapDifferences.add(_formatTime(lapDifference));

//       // Update the previous lap time
//       _previousLapTime = currentLapTime;
//     });
//   }

//   String _formatTime(int seconds) {
//     int minutes = seconds ~/ 60;
//     int remainingSeconds = seconds % 60;
//     return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Stopwatch with Laps and Time Difference")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               _formatTime(_elapsedTime), // Display overall time
//               style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: _isRunning ? null : _startStopwatch,
//                   child: Text("Start"),
//                 ),
//                 SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: !_isRunning && _elapsedTime == 0 ? null : _stopStopwatch,
//                   child: Text("Stop"),
//                 ),
//                 SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: _resetStopwatch,
//                   child: Text("Reset"),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isRunning ? _recordLap : null,
//               child: Text("Lap"),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _laps.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text("Lap ${index + 1}: ${_laps[index]}"),
//                     subtitle: Text("Lap Time: ${_lapDifferences[index]}"),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
