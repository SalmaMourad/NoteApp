
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/toDoList/providers/toDoListprovider.dart';
import 'package:simple_notes_app/toDoList/screens/ToDoEditScreen.dart';
// import '../providers/notes_provider.dart';
// import 'note_detail_screen.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  String? selectedFolder;

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<ToDoListProvider>(context);
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
                      ToDoEditScreen(folder: selectedFolder),
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
            Card( color: Color.fromARGB(255, 253, 248, 242),
              child: ListTile(
                title: Text("All Notes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                onTap: () {
                  setState(() {
                    selectedFolder = null;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
            ...notesProvider.folders.map((folder) => Card(
              color: Color.fromARGB(255, 253, 248, 242),
              child: ListTile(
                    title: Text(folder,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
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
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                notesProvider.deleteNote(note.id);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                child: Card(
                    color: note.priority, // Apply the selected color
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(note.task,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18) ,),
                          // Spacer(flex: 1,),
                          SizedBox(width: 10,),
                         Text(
                            '${note.deadline.toLocal().toString().split(' ')[0]}', // Displaying formatted date
                          style:TextStyle(fontSize: 11) ),],
                      ),
                      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${note.isDone}' // Displaying formatted date
                         , style:TextStyle(fontSize: 17) ),
                         //Created:
                        //  Text(
                        //     '${note.dateCreated.toLocal().toString().split(' ')[0]}', // Displaying formatted date
                        //   style:TextStyle(fontSize: 13) ),
                        ],
                      ),
                      trailing: IconButton(onPressed: (){notesProvider.deleteNote(note.id);}, icon: Icon(Icons.delete)),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ToDoEditScreen(todo: note),
                          ),
                        );
                      },
                    )),
              ));
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
