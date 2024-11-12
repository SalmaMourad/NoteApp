import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/Timer/StopwatchProvider.dart';
import 'package:simple_notes_app/Timer/TimerProvider_Screen.dart';
import 'package:simple_notes_app/n/navBar.dart';
import 'package:simple_notes_app/providers/notes_provider.dart';
import 'package:simple_notes_app/toDoList/providers/toDoListprovider.dart';
// import 'stopwatch_provider.dart'; // Your StopwatchProvider file
// import 'main_app.dart'; // The file where MainApp and TimerStopwatchToggleScreen are defined

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(
      create: (context) => ToDoListProvider(),),
        ChangeNotifierProvider(
      create: (context) => NotesProvider(),),
        ChangeNotifierProvider(create: (_) => StopwatchProvider()), // Stopwatch Provider
     ChangeNotifierProvider(
          create: (context) => TimerProvider(),
        ),  ],
      child: MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Timer and Stopwatch App',
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        home: MainApp(), // Main application screen with BottomNavigationBar
      ),
    );
  }
}
