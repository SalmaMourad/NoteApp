import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/Timer/Stopwatch.dart';
import 'package:simple_notes_app/Timer/TimerProvider_Screen.dart';
import 'package:simple_notes_app/Timer/ToggleButtonsScreen.dart';
import 'package:simple_notes_app/screens/notes_list_screen.dart';
import 'package:simple_notes_app/toDoList/screens/ToDoScreen.dart';
// import 'stopwatch_provider.dart';
// import 'customizable_stopwatch.dart'; // Your CustomizableStopwatch widget
// import 'timer_screen.dart'; // Your Timer screen widget

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;
  bool isTimerSelected = true;

  // List of screens to display based on the selected index
  final List<Widget> _pages = [
    NotesListScreen(), // Replace with your Home screen or another screen widget
    ToDoScreen(), // Replace with your second page widget
    // Timer and Stopwatch Toggle Page
    ToggleWidgetsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_sharp),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Timer/Stopwatch',
          ),
        ],
      ),
    );
  }
}

// Timer and Stopwatch Toggle Page
// class TimerStopwatchToggleScreen extends StatefulWidget {
//   @override
//   _TimerStopwatchToggleScreenState createState() =>
//       _TimerStopwatchToggleScreenState();
// }

// class _TimerStopwatchToggleScreenState extends State<TimerStopwatchToggleScreen> {
//   bool isTimerSelected = true;

//   void toggleMode() {
//     setState(() {
//       isTimerSelected = !isTimerSelected;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isTimerSelected ? "Timer" : "Stopwatch"),
//         actions: [
//           IconButton(
//             icon: Icon(isTimerSelected ? Icons.timer : Icons.timer_off),
//             onPressed: toggleMode,
//           ),
//         ],
//       ),
//       body: Center(
//         child: isTimerSelected
//             ? TimerScreen() // Replace with your Timer widget
//             : CustomizableStopwatch(), // Replace with your Stopwatch widget
//       ),
//     );
//   }
// }
