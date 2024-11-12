// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:simple_notes_app/Timer/TimerProvider.dart';
// import 'package:simple_notes_app/Timer/toggle.dart';
// // import 'timer_provider.dart'; // Assuming TimerProvider is in this file
// // import 'widget1.dart'; // Your Widget1 screen

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => TimerProvider(),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Widget1(),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'timer_provider.dart'; // Assuming TimerProvider is in this file

// class Widget1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final timerProvider = Provider.of<TimerProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Timer'),
//       ),
//       body: Center(
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
//                   MaterialPageRoute(builder: (context) => AnotherScreen()),
//                 );
//               },
//               child: Text('Go to Another Screen'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
