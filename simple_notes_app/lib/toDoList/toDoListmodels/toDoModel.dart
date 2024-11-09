// import 'dart:ui';

import 'dart:ffi';
import 'package:flutter/material.dart';

class TodoListmodel {
  final String id;
  String task;
  String? isDone;
  String? folder;
  DateTime deadline;
  Color priority;

  TodoListmodel({
    required this.id,
    required this.task,
    required this.isDone,
    this.folder,
    required this.deadline,
    required this.priority,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': task,
      'description': isDone,
      'folder': folder,
      'dateCreated': deadline.toIso8601String(), // Format date to ISO string
      'color': priority.value, // Save color as int
    };
  }

  factory TodoListmodel.fromJson(Map<String, dynamic> json) {
    return TodoListmodel(
      id: json['id'],
      task: json['title'],
      isDone: json['description'],
      folder: json['folder'],
      deadline: DateTime.parse(json['dateCreated']),
      priority: Color(json['color'] ??
          Colors.yellow.value), // Default to white if color is null
    );
  }
}
