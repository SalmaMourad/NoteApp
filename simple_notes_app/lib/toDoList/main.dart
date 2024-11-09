import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/toDoList/providers/toDoListprovider.dart';
import 'package:simple_notes_app/toDoList/screens/ToDoScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ToDoListProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple Notes App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ToDoScreen(),
      ),
    );
  }
}
