import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  NotesProvider() {
    _loadNotes();
  }

  void addNote(Note note) {
    _notes.add(note);
    _saveNotes();
    notifyListeners();
  }

  void updateNote(String id, String title, String description) {
    final noteIndex = _notes.indexWhere((note) => note.id == id);
    if (noteIndex != -1) {
      _notes[noteIndex].title = title;
      _notes[noteIndex].description = description;
      _saveNotes();
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    _saveNotes();
    notifyListeners();
  }

  void _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = jsonEncode(_notes.map((note) => note.toJson()).toList());
    prefs.setString('notes', notesJson);
  }

  void _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getString('notes');
    if (notesJson != null) {
      final List<dynamic> notesList = jsonDecode(notesJson);
      _notes = notesList.map((item) => Note.fromJson(item)).toList();
      notifyListeners();
    }
  }
}

// import 'package:flutter/material.dart';
// import '../models/note.dart';

// class NotesProvider with ChangeNotifier {
//   List<Note> _notes = [];

//   List<Note> get notes => _notes;

//   void addNote(Note note) {
//     _notes.add(note);
//     notifyListeners();
//   }

//   void updateNote(String id, String title, String description) {
//     final noteIndex = _notes.indexWhere((note) => note.id == id);
//     if (noteIndex != -1) {
//       _notes[noteIndex].title = title;
//       _notes[noteIndex].description = description;
//       notifyListeners();
//     }
//   }

//   void deleteNote(String id) {
//     _notes.removeWhere((note) => note.id == id);
//     notifyListeners();
//   }
// }
