import 'package:flutter/material.dart';

class TodoListModel {
  final String id;
  String task;
  bool isDone;
  String? folder;
  DateTime? deadline;
  Color priority;

  TodoListModel({
    required this.id,
    required this.task,
    this.isDone = false, // Default to false if not provided
    this.folder,
    this.deadline,
    required this.priority,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': task,
      'isDone': isDone, // Correct field name for isDone
      'folder': folder,
      'dateCreated': deadline?.toIso8601String(), // Format date to ISO string
      'color': priority.value, // Save color as int
    };
  }

  factory TodoListModel.fromJson(Map<String, dynamic> json) {
    return TodoListModel(
      id: json['id'],
      task: json['title'],
      isDone: json['isDone'] == true, // Convert boolean directly
      folder: json['folder'],
      deadline: json['dateCreated'] != null ? DateTime.parse(json['dateCreated']) : null,
      priority: Color(json['color'] ?? Colors.yellow.value), // Default color
    );
  }
}

// import 'package:flutter/material.dart';

// class TodoListModel {
//   final String id;
//   String task;
//   bool isDone;
//   String? folder;
//   DateTime? deadline;
//   Color priority;

//   TodoListModel({
//     required this.id,
//     required this.task,
//     this.isDone = false, // Default to false if not provided
//     this.folder,
//     this.deadline,
//     required this.priority,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': task,
//       'description': isDone, // Serialize as boolean
//       'folder': folder,
//       'dateCreated': deadline?.toIso8601String(), // Format date to ISO string
//       'color': priority.value, // Save color as int
//     };
//   }

// factory TodoListModel.fromJson(Map<String, dynamic> json) {
//   return TodoListModel(
//     id: json['id'],
//     task: json['title'],
//     isDone: json['description'] == 'true', // Convert string to boolean
//     folder: json['folder'],
//     deadline: json['dateCreated'] != null ? DateTime.parse(json['dateCreated']) : null,
//     priority: Color(json['color'] ?? Colors.yellow.value), // Default color
//   );
// }

// }

// // import 'dart:ui';

// // import 'dart:ffi';
// import 'dart:ffi';

// import 'package:flutter/material.dart';

// class TodoListmodel {
//   final String id;
//   String task;
//   Bool? isDone;

//   String? folder;
//   DateTime? deadline;
//   Color priority;

//   TodoListmodel({
//     required this.id,
//     required this.task,
//     required this.isDone,
//     this.folder,
//     required this.deadline,
//     required this.priority,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': task,
//       'description': isDone,
//       'folder': folder,
//       'dateCreated': deadline?.toIso8601String(), // Format date to ISO string
//       'color': priority.value, // Save color as int
//     };
//   }

//   factory TodoListmodel.fromJson(Map<String, dynamic> json) {
//     return TodoListmodel(
//       id: json['id'],
//       task: json['title'],
//       isDone: json['description'],
//       folder: json['folder'],
//       deadline: DateTime.parse(json['dateCreated']),
//       priority: Color(json['color'] ??
//           Colors.yellow.value), // Default to white if color is null
//     );
//   }
// }
