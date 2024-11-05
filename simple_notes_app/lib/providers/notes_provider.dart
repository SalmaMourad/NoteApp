import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];
  List<String> _folders = []; // List of folder names

  List<Note> get notes => _notes;
  List<String> get folders => _folders;

  NotesProvider() {
    _loadNotes();
  }

  void addNote(Note note) {
    _notes.add(note);
    _saveNotes();
    notifyListeners();
  }

  void updateNote(String id, String title, String description, String? folder,
      Color selectedColor) {
    final noteIndex = _notes.indexWhere((note) => note.id == id);
    if (noteIndex != -1) {
      _notes[noteIndex].title = title;
      _notes[noteIndex].description = description;
      _notes[noteIndex].folder = folder;
      _notes[noteIndex].color = selectedColor; // Update color
      // update the dateCreated
      // _notes[noteIndex].dateCreated = DateTime.now();
      _saveNotes();
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    _saveNotes();
    notifyListeners();
  }

  void addFolder(String folderName) {
    if (!_folders.contains(folderName)) {
      _folders.add(folderName);
      _saveNotes();
      notifyListeners();
    }
  }

  List<Note> getNotesByFolder(String? folder) {
    if (folder == null) {
      return _notes.where((note) => note.folder == null).toList();
    } else {
      return _notes.where((note) => note.folder == folder).toList();
    }
  }

  void _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = jsonEncode(_notes.map((note) => note.toJson()).toList());
    final foldersJson = jsonEncode(_folders);
    prefs.setString('notes', notesJson);
    prefs.setString('folders', foldersJson);
  }

  void _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getString('notes');
    final foldersJson = prefs.getString('folders');
    if (notesJson != null) {
      final List<dynamic> notesList = jsonDecode(notesJson);
      _notes = notesList.map((item) => Note.fromJson(item)).toList();
    }
    if (foldersJson != null) {
      _folders = List<String>.from(jsonDecode(foldersJson));
    }
    notifyListeners();
  }
}
