import 'package:flutter/material.dart';
import 'package:flutter_check_box_rounded/flutter_check_box_rounded.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/n/n.dart';
import 'package:simple_notes_app/toDoList/providers/toDoListprovider.dart';
import 'package:simple_notes_app/toDoList/screens/ToDoEditScreen.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  String? selectedFolder;

  Map<String, Color> priorityOptions = {
    'High Priority': Colors.red,
    'Medium Priority': Colors.orange,
    'Low Priority': Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<ToDoListProvider>(context);
    final notes = notesProvider.getNotesByFolder(selectedFolder);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(selectedFolder == null ? 'My Tasks' : selectedFolder!),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ToDoEditScreen(folder: selectedFolder),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.folder),
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
            Card(
              color: const Color.fromARGB(255, 253, 248, 242),
              child: ListTile(
                title: const Text("All Notes",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                onTap: () {
                  setState(() {
                    selectedFolder = null;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
            ...notesProvider.folders.map((folder) => Card(
                  color: const Color.fromARGB(255, 253, 248, 242),
                  child: ListTile(
                    title: Text(folder,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    onTap: () {
                      setState(() {
                        selectedFolder = folder;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
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
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              notesProvider.deleteNote(note.id);
            },
            child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                child: Card(
                  color: Color.fromARGB(255, 254, 254, 251),
                  child: ListTile(
                    leading: CheckBoxRounded(
                      borderWidth: 1.5,
                      isChecked: note.isDone,
                      uncheckedColor: Colors.white,
                      checkedColor: Colors.deepPurple,
                      borderColor: Colors.grey,
                      onTap: (isChecked) {
                        setState(() {
                          notesProvider.toggleNoteStatus(note.id, isChecked!);
                        });
                      },
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            note.task,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              decoration: note.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                            overflow:
                                TextOverflow.ellipsis, // Prevents overflow
                          ),
                        ),
                        // Assuming the 'note' object has a 'priority' field to store the color.
                        PopupMenuButton<Color>(
                          icon: Icon(Icons.flag,
                              color: note.priority ?? Colors.green,
                              size: 24), // Default to green
                          padding: EdgeInsets.zero, // Remove any extra padding
                          onSelected: (Color newColor) {
                            // Update the color for the specific task (note)
                            setState(() {
                              note.priority =
                                  newColor; // Update the color for this specific task
                            });

                            // Update the note with the new color
                            notesProvider.updateNote(
                              note.id,
                              note.task,
                              note.isDone,
                              note.folder,
                              note.priority, // Send the updated priority color
                              note.deadline ?? DateTime.now(),
                            );
                          },
                          itemBuilder: (BuildContext context) {
                            return priorityOptions.entries.map((entry) {
                              return PopupMenuItem<Color>(
                                value: entry.value,
                                child: Row(
                                  children: [
                                    Icon(Icons.flag,
                                        color: entry.value,
                                        size: 24), // Display each color option
                                    const SizedBox(width: 8),
                                    Text(entry.key),
                                  ],
                                ),
                              );
                            }).toList();
                          },
                        ),

                        IconButton(
                          onPressed: () {
                            notesProvider.deleteNote(note.id);
                          },
                          icon: const Icon(Icons.delete_outline_outlined,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${note.deadline?.toLocal().toString().split(' ')[0]}',
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ToDoEditScreen(todo: note),
                        ),
                      );
                    },
                  ),
                )),
          );
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
          title: const Text('Create Folder'),
          content: TextField(
            controller: folderController,
            decoration: const InputDecoration(labelText: 'Folder Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, folderController.text),
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
