
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/notes_provider.dart';
class NoteDetailScreen extends StatefulWidget {
  final Note? note;
  final String? folder; // Folder passed from previous screen

  NoteDetailScreen({this.note, this.folder});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
  }

  // void _saveNote() {
  //   final title = _titleController.text;
  //   final description = _descriptionController.text;

  //   if (title.isEmpty || description.isEmpty) return;

  //   final folder = widget.folder;

  //   if (widget.note != null) {
  //     Provider.of<NotesProvider>(context, listen: false).updateNote(
  //       widget.note!.id,
  //       title,
  //       description,
  //       folder,
  //     );
  //   } else {
  //     final newNote = Note(
  //       id: DateTime.now().toString(),
  //       title: title,
  //       description: description,
  //       folder: folder,
  //     );
  //     Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
  //   }
  //   Navigator.of(context).pop();
  // }
  void _saveNote() {
  final title = _titleController.text;
  final description = _descriptionController.text;

  if (title.isEmpty || description.isEmpty) return;

  // Check if there’s a folder assigned to the note or to the screen itself
  final folder = widget.folder ?? widget.note?.folder;

  if (widget.note != null) {
    // Update the existing note, preserving its folder
    Provider.of<NotesProvider>(context, listen: false).updateNote(
      widget.note!.id,
      title,
      description,
      folder, // Pass the folder field to keep it consistent
    );
  } else {
    // Create a new note with the specified folder
    final newNote = Note(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      folder: folder, // Assign the folder to the new note
    );
    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
  }
  Navigator.of(context).pop();
}



  void _deleteNote() {
    if (widget.note != null) {
      Provider.of<NotesProvider>(context, listen: false)
          .deleteNote(widget.note!.id);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note != null ? 'Edit Note' : 'New Note'),
        actions: [
          if (widget.note != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _deleteNote,
            ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
