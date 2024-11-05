import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import 'note_detail_screen.dart';

class NotesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NoteDetailScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notesProvider.notes.length,
        itemBuilder: (context, index) {
          final note = notesProvider.notes[index];
          return Dismissible(
            key: ValueKey(note.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              notesProvider.deleteNote(note.id);
            },
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(note.description),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NoteDetailScreen(note: note),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
