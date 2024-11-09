import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_notes_app/toDoList/toDoListmodels/toDoModel.dart';
// import '../models/note.dart';

class ToDoListProvider with ChangeNotifier {
  List<TodoListmodel> _toDo = [];
  List<String> _folders = []; // List of folder names

  List<TodoListmodel> get notes => _toDo;
  List<String> get folders => _folders;

  ToDoListProvider() {
    _loadNotes();
  }

  void addNote(TodoListmodel note) {
    _toDo.add(note);
    _saveNotes();
    notifyListeners();
  }

  void updateNote(String id, String task, bool? description, String? folder,
      Color selectedColor) {
    final noteIndex = _toDo.indexWhere((note) => note.id == id);
    if (noteIndex != -1) {
      _toDo[noteIndex].task = task;
      _toDo[noteIndex].isDone = description as Bool?;
      _toDo[noteIndex].folder = folder;
      _toDo[noteIndex].priority = selectedColor; // Update color
      // update the dateCreated
      // _notes[noteIndex].dateCreated = DateTime.now();
      _saveNotes();
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _toDo.removeWhere((note) => note.id == id);
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

  List<TodoListmodel> getNotesByFolder(String? folder) {
    if (folder == null) {
      return _toDo.where((note) => note.folder == null).toList();
    } else {
      return _toDo.where((note) => note.folder == folder).toList();
    }
  }

  void _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = jsonEncode(_toDo.map((note) => note.toJson()).toList());
    final foldersJson = jsonEncode(_folders);
    prefs.setString('toDoList', notesJson);
    prefs.setString('folders', foldersJson);
  }

  void _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getString('toDoList');
    final foldersJson = prefs.getString('folders');
    if (notesJson != null) {
      final List<dynamic> notesList = jsonDecode(notesJson);
      _toDo = notesList.map((item) => TodoListmodel.fromJson(item)).toList();
    }
    if (foldersJson != null) {
      _folders = List<String>.from(jsonDecode(foldersJson));
    }
    notifyListeners();
  }
}
