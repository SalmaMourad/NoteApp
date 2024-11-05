import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import 'note_detail_screen.dart';

class NotesListScreen extends StatefulWidget {
  @override
  _NotesListScreenState createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  String? selectedFolder;

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    final notes = notesProvider.getNotesByFolder(selectedFolder);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedFolder == null ? 'My Notes' : selectedFolder!),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      NoteDetailScreen(folder: selectedFolder),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.folder),
            onPressed: () async {
              String? folderName = await _showCreateFolderDialog(context);
              if (folderName != null && folderName.isNotEmpty) {
                notesProvider.addFolder(folderName);
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("All Notes"),
              onTap: () {
                setState(() {
                  selectedFolder = null;
                });
                Navigator.of(context).pop();
              },
            ),
            ...notesProvider.folders.map((folder) => ListTile(
                  title: Text(folder),
                  onTap: () {
                    setState(() {
                      selectedFolder = folder;
                    });
                    Navigator.of(context).pop();
                  },
                )),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
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
              child: Card(
                  color: note.color, // Apply the selected color
                  child: ListTile(
                    title: Text(note.title,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18) ,),
                    subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${note.description}' // Displaying formatted date
                       , style:TextStyle(fontSize: 17) ),
                       //Created:
                       Text(
                          '${note.dateCreated.toLocal().toString().split(' ')[0]}', // Displaying formatted date
                        style:TextStyle(fontSize: 13) ),
                      ],
                    ),
                    trailing: IconButton(onPressed: (){notesProvider.deleteNote(note.id);}, icon: Icon(Icons.delete)),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NoteDetailScreen(note: note),
                        ),
                      );
                    },
                  )));
        },
      ),
    );
  }

  Future<String?> _showCreateFolderDialog(BuildContext context) async {
    final TextEditingController folderController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Folder'),
          content: TextField(
            controller: folderController,
            decoration: InputDecoration(labelText: 'Folder Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, folderController.text),
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
