// import 'dart:ui';

import 'package:flutter/material.dart';

class Note {
  final String id;
  String title;
  String description;
  String? folder;
  DateTime dateCreated;
  Color color;

  Note({
    required this.id,
    required this.title,
    required this.description,
    this.folder,
    required this.dateCreated,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'folder': folder,
      'dateCreated': dateCreated.toIso8601String(), // Format date to ISO string
      'color': color.value, // Save color as int
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      folder: json['folder'],
      dateCreated: DateTime.parse(json['dateCreated']),
      color: Color(json['color'] ??
          Colors.white.value), // Default to white if color is null
    );
  }
}
