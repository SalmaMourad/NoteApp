import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import '../models/note.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note? note;
  final String? folder;

  NoteDetailScreen({this.note, this.folder});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedFolder;
  Color _selectedColor = Colors.white;
  final List<Color> _colors = [
    Color.fromARGB(218, 255, 219, 88),
    Color.fromARGB(255, 232, 109, 101),
    Color.fromARGB(255, 130, 174, 250),
    Color.fromARGB(255, 148, 244, 150),
    Color.fromARGB(255, 202, 130, 250)
  ];
  String colorToHex(Color color) {
    return '#${color.alpha.toRadixString(16).padLeft(2, '0')}${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }

  List<Color> colorOptions = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.yellow,
    Colors.purple,
    Colors.brown,
    Colors.cyan,
    Colors.teal,
    Colors.pink,
  ];
  Widget _buildColorPicker() {
    return Column(
      children: [
        Text("Choose Color:"),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: colorOptions.map((color) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = color;
                });
              },
              child: CircleAvatar(
                radius: 25,
                backgroundColor: color,
                child: _selectedColor == color
                    ? Icon(Icons.check, color: Colors.white)
                    : Container(), // Show a check mark on the selected color
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedFolder = widget.folder ?? widget.note?.folder;
    _selectedColor = widget.note?.color ??
        Colors.white; // Ensure color is initialized from the note

    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
  }

  void _saveNote() {
    final title = _titleController.text;
    final description = _descriptionController.text;

    if (title.isEmpty || description.isEmpty) return;

    if (widget.note != null) {
      // Update the existing note
      Provider.of<NotesProvider>(context, listen: false).updateNote(
        widget.note!.id,
        title,
        description,
        _selectedFolder,
        _selectedColor, // Ensure selected color is passed here
      );
    } else {
      // Create a new note
      final newNote = Note(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        folder: _selectedFolder,
        dateCreated: DateTime.now(),
        color: _selectedColor, // Assign the selected color to the new note
      );
      Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final folders = Provider.of<NotesProvider>(context).folders;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            DropdownButton<String?>(
              value: _selectedFolder,
              onChanged: (String? newFolder) {
                setState(() {
                  _selectedFolder = newFolder;
                });
              },
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text('Main Notes'),
                ),
                ...folders.map((folder) => DropdownMenuItem<String?>(
                      value: folder,
                      child: Text(folder),
                    )),
              ],
            ),
            SizedBox(height: 20),
            _buildColorPicker(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text(widget.note == null ? 'Add Note' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickColor(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  _selectedColor = color;
                });
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }
}
