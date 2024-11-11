import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_notes_app/toDoList/toDoListmodels/toDoModel.dart';

class ToDoListProvider with ChangeNotifier {
  List<TodoListModel> _toDo = [];
  List<String> _folders = []; // List of folder names

  List<TodoListModel> get notes => _toDo;
  List<String> get folders => _folders;

  ToDoListProvider() {
    _loadNotes();
  }

  void addNote(TodoListModel note) {
    _toDo.add(note);
    _saveNotes();
    notifyListeners();
  }

  void updateNote(String id, String task, bool isDone, String? folder, Color selectedColor, DateTime date) {
    final noteIndex = _toDo.indexWhere((note) => note.id == id);
    if (noteIndex != -1) {
      _toDo[noteIndex].task = task;
      _toDo[noteIndex].isDone = isDone;
      _toDo[noteIndex].folder = folder;
      _toDo[noteIndex].priority = selectedColor;
      _toDo[noteIndex].deadline = date;

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

  List<TodoListModel> getNotesByFolder(String? folder) {
    if (folder == null) {
      return _toDo.where((note) => note.folder == null).toList();
    } else {
      return _toDo.where((note) => note.folder == folder).toList();
    }
  }

  void toggleNoteStatus(String id, bool isChecked) {
    final noteIndex = _toDo.indexWhere((note) => note.id == id);
    if (noteIndex != -1) {
      _toDo[noteIndex].isDone = isChecked;
      _saveNotes();
      notifyListeners();
    }
  }

  // New Method: Toggle Priority
  // void togglePriority(String id) {
  //   final noteIndex = _toDo.indexWhere((note) => note.id == id);
  //   if (noteIndex != -1) {
  //     final currentPriority = _toDo[noteIndex].priority;

  //     // Cycle through priority levels (high -> medium -> low)
  //     if (currentPriority == Colors.red) {
  //       _toDo[noteIndex].priority = Colors.orange; // Medium priority
  //     } else if (currentPriority == Colors.orange) {
  //       _toDo[noteIndex].priority = Colors.green; // Low priority
  //     } else {
  //       _toDo[noteIndex].priority = Colors.red; // High priority
  //     }

  //     _saveNotes();
  //     notifyListeners();
  //   }
  // }
  void togglePriority(String id) {
  final noteIndex = _toDo.indexWhere((note) => note.id == id);
  if (noteIndex != -1) {
    // Cycle through colors or set specific ones
    final currentColor = _toDo[noteIndex].priority;
    _toDo[noteIndex].priority = (currentColor == Colors.red)
        ? Colors.orange
        : (currentColor == Colors.orange)
            ? Colors.green
            : Colors.red;
    _saveNotes();
    notifyListeners();
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
      _toDo = notesList.map((item) => TodoListModel.fromJson(item)).toList();
    }
    if (foldersJson != null) {
      _folders = List<String>.from(jsonDecode(foldersJson));
    }
    notifyListeners();
  }
}





// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:simple_notes_app/toDoList/toDoListmodels/toDoModel.dart';

// class ToDoListProvider with ChangeNotifier {
//   List<TodoListModel> _toDo = [];
//   List<String> _folders = []; // List of folder names

//   List<TodoListModel> get notes => _toDo;
//   List<String> get folders => _folders;

//   ToDoListProvider() {
//     _loadNotes();
//   }

//   void addNote(TodoListModel note) {
//     _toDo.add(note);
//     _saveNotes();
//     notifyListeners();
//   }

//   void updateNote(String id, String task, bool isDone, String? folder, Color selectedColor,DateTime date) {
//     final noteIndex = _toDo.indexWhere((note) => note.id == id);
//     if (noteIndex != -1) {
//       _toDo[noteIndex].task = task;
//       _toDo[noteIndex].isDone = isDone; // Update isDone as boolean
//       _toDo[noteIndex].folder = folder;
//       _toDo[noteIndex].priority = selectedColor; // Update color
//       //////////////////////////////////////////////////////////////////////////////////////////////////////
//       // _toDo[noteIndex].deadline = DateTime.now();
//       _toDo[noteIndex].deadline = date;

//       _saveNotes();
//       notifyListeners();
//     }
//   }

//   void deleteNote(String id) {
//     _toDo.removeWhere((note) => note.id == id);
//     _saveNotes();
//     notifyListeners();
//   }

//   void addFolder(String folderName) {
//     if (!_folders.contains(folderName)) {
//       _folders.add(folderName);
//       _saveNotes();
//       notifyListeners();
//     }
//   }

//   List<TodoListModel> getNotesByFolder(String? folder) {
//     if (folder == null) {
//       return _toDo.where((note) => note.folder == null).toList();
//     } else {
//       return _toDo.where((note) => note.folder == folder).toList();
//     }
//   }

//   void toggleNoteStatus(String id, bool bool) {
//     final noteIndex = _toDo.indexWhere((note) => note.id == id);
//     if (noteIndex != -1) {
//       _toDo[noteIndex].isDone = !_toDo[noteIndex].isDone; // Toggle isDone status
//       _saveNotes();
//       notifyListeners();
//     }
//   }

//   void _saveNotes() async {
//     final prefs = await SharedPreferences.getInstance();
//     final notesJson = jsonEncode(_toDo.map((note) => note.toJson()).toList());
//     final foldersJson = jsonEncode(_folders);
//     prefs.setString('toDoList', notesJson);
//     prefs.setString('folders', foldersJson);
//   }

//   void _loadNotes() async {
//     final prefs = await SharedPreferences.getInstance();
//     final notesJson = prefs.getString('toDoList');
//     final foldersJson = prefs.getString('folders');
//     if (notesJson != null) {
//       final List<dynamic> notesList = jsonDecode(notesJson);
//       _toDo = notesList.map((item) => TodoListModel.fromJson(item)).toList();
//     }
//     if (foldersJson != null) {
//       _folders = List<String>.from(jsonDecode(foldersJson));
//     }
//     notifyListeners();
//   }
// }

// import 'dart:convert';
// import 'dart:ffi';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:simple_notes_app/toDoList/toDoListmodels/toDoModel.dart';
// // import '../models/note.dart';

// class ToDoListProvider with ChangeNotifier {
//   List<TodoListmodel> _toDo = [];
//   List<String> _folders = []; // List of folder names

//   List<TodoListmodel> get notes => _toDo;
//   List<String> get folders => _folders;

//   ToDoListProvider() {
//     _loadNotes();
//   }

//   void addNote(TodoListmodel note) {
//     _toDo.add(note);
//     _saveNotes();
//     notifyListeners();
//   }

//   void updateNote(String id, String task,String description, String? folder,
//       Color selectedColor) {
//     final noteIndex = _toDo.indexWhere((note) => note.id == id);
//     if (noteIndex != -1) {
//       _toDo[noteIndex].task = task;
//       _toDo[noteIndex].isDone = description ;
//       _toDo[noteIndex].folder = folder;
//       _toDo[noteIndex].priority = selectedColor; // Update color
//       // update the dateCreated
//       // _notes[noteIndex].dateCreated = DateTime.now();
//       _saveNotes();
//       notifyListeners();
//     }
//   }

//   void deleteNote(String id) {
//     _toDo.removeWhere((note) => note.id == id);
//     _saveNotes();
//     notifyListeners();
//   }

//   void addFolder(String folderName) {
//     if (!_folders.contains(folderName)) {
//       _folders.add(folderName);
//       _saveNotes();
//       notifyListeners();
//     }
//   }

//   List<TodoListmodel> getNotesByFolder(String? folder) {
//     if (folder == null) {
//       return _toDo.where((note) => note.folder == null).toList();
//     } else {
//       return _toDo.where((note) => note.folder == folder).toList();
//     }
//   }

//   void _saveNotes() async {
//     final prefs = await SharedPreferences.getInstance();
//     final notesJson = jsonEncode(_toDo.map((note) => note.toJson()).toList());
//     final foldersJson = jsonEncode(_folders);
//     prefs.setString('toDoList', notesJson);
//     prefs.setString('folders', foldersJson);
//   }

//   void _loadNotes() async {
//     final prefs = await SharedPreferences.getInstance();
//     final notesJson = prefs.getString('toDoList');
//     final foldersJson = prefs.getString('folders');
//     if (notesJson != null) {
//       final List<dynamic> notesList = jsonDecode(notesJson);
//       _toDo = notesList.map((item) => TodoListmodel.fromJson(item)).toList();
//     }
//     if (foldersJson != null) {
//       _folders = List<String>.from(jsonDecode(foldersJson));
//     }
//     notifyListeners();
//   }
// }
