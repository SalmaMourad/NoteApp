import 'package:flutter/material.dart';
import 'package:flutter_check_box_rounded/flutter_check_box_rounded.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/toDoList/providers/toDoListprovider.dart';
import 'package:simple_notes_app/toDoList/screens/ToDoEditScreen.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  String? selectedFolder;
// Priority color options
  // final Map<String, Color> priorityOptions = {
  //   "High Priority": Colors.red,
  //   "Medium Priority": Colors.orange,
  //   "Low Priority": Colors.green,
  // };
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
        title: Text(selectedFolder == null ? 'My Notes' : selectedFolder!),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ToDoEditScreen(folder: selectedFolder),
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
            Card(
              color: Color.fromARGB(255, 253, 248, 242),
              child: ListTile(
                title: Text("All Notes",
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
                  color: Color.fromARGB(255, 253, 248, 242),
                  child: ListTile(
                    title: Text(folder,
                        style: TextStyle(
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
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              notesProvider.deleteNote(note.id);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
              child: Card(
                color: Colors.white,
                // color: note.priority,
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
                      Text(
                        note.task,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          decoration:
                              note.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${note.deadline?.toLocal().toString().split(' ')[0]}',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //                 IconButton(
                      //   icon: Icon(Icons.flag, color: note.priority),
                      //   onPressed: () {
                      //     setState(() {
                      //       notesProvider.togglePriority(note.id);
                      //     });
                      //   },
                      // ),
                      //   IconButton(
                      // icon: Icon(Icons.flag, color: note.priority),
                      // onPressed: () {
                      //   setState(() {
                      //     notesProvider.togglePriority(note.id);
                      //   });
                      // },
                      // ),
                      // IconButton(
                      //   icon: Icon(Icons.flag, color: note.priority),
                      //   onPressed: () {
                      //     setState(() {
                      //       notesProvider.togglePriority(note.id);
                      //     });
                      //   },
                      // ),
                      // IconButton(
                      //                     icon: Icon(Icons.flag, color: note.priority),
                      //                     onPressed: () async {
                      //                       Color? newColor = await _showPriorityDropdown(context, note.priority);
                      //                       if (newColor != null) {
                      //                         notesProvider.updateNote(
                      //                           note.id,
                      //                           note.task,
                      //                           note.isDone,
                      //                           note.folder,
                      //                           newColor,
                      //                           note.deadline ?? DateTime.now(),
                      //                         );
                      //                       }
                      //                     },
                      //                   ),              // IconButton(onPressed: (){}, icon: Icon(Icons.abc_outlined)),
                      // IconButton(
                      //   icon: Icon(
                      //     note.priority == Colors.red
                      //         ? Icons.flag_outlined
                      //         : note.priority == Colors.orange
                      //             ? Icons.flag_outlined
                      //             : Icons.flag_outlined,
                      //     color: note.priority ?? Colors.green,
                      //   ),
                      //   onPressed: () {
                      //     notesProvider.togglePriority(note.id);
                      //   },
                      // ),
                      // DropdownButton<Color>(
                      //   value: note.priority,
                      //   icon: Icon(Icons.flag, color: note.priority),
                      //   underline: Container(),
                      //   items: priorityOptions.entries.map((entry) {
                      //     return DropdownMenuItem<Color>(
                      //       value: entry.value,
                      //       child: Row(
                      //         children: [
                      //           Icon(Icons.flag, color: entry.value),
                      //           SizedBox(width: 8),
                      //           Text(entry.key),
                      //         ],
                      //       ),
                      //     );
                      //   }).toList(),
                      //   onChanged: (Color? newColor) {
                      //     if (newColor != null) {
                      //       notesProvider.updateNote(
                      //         note.id,
                      //         note.task,
                      //         note.isDone,
                      //         note.folder,
                      //         newColor,
                      //         note.deadline ?? DateTime.now(),
                      //       );
                      //     }
                      //   },
                      // ),
//                       DropdownButton<Color>(
//   value: priorityOptions.values.contains(note.priority) ? note.priority : null, // Ensure value is in items
//   icon: Icon(Icons.flag, color: note.priority),
//   underline: Container(),
//   items: priorityOptions.entries.map((entry) {
//     return DropdownMenuItem<Color>(
//       value: entry.value,
//       child: Row(
//         children: [
//           Icon(Icons.flag, color: entry.value),
//           SizedBox(width: 8),
//           Text(entry.key),
//         ],
//       ),
//     );
//   }).toList(),
//   onChanged: (Color? newColor) {
//     if (newColor != null) {
//       notesProvider.updateNote(
//         note.id,
//         note.task,
//         note.isDone,
//         note.folder,
//         newColor,
//         note.deadline ?? DateTime.now(),
//       );
//     }
//   },
// ),
                      DropdownButton<Color>(
                        // value: priorityOptions.containsValue(note.priority) ? note.priority : null, // Only assign if it's a valid option
                        icon: Icon(Icons.flag,
                            color: note.priority), // Color of the flag icon
                        underline: Container(), // No underline
                        items: priorityOptions.entries.map((entry) {
                          return DropdownMenuItem<Color>(
                            value: entry.value, // The actual color to set
                            child: Row(
                              children: [
                                Icon(Icons.flag,
                                    color: entry
                                        .value), // Display the color of the flag
                                SizedBox(width: 8),
                                Text(entry
                                    .key), // Display the label for the priority
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (Color? newColor) {
                          if (newColor != null) {
                            notesProvider.updateNote(
                              note.id,
                              note.task,
                              note.isDone,
                              note.folder,
                              newColor, // Update only the priority color
                              note.deadline ?? DateTime.now(),
                            );
                          }
                        },
                      ),

                      IconButton(
                        onPressed: () {
                          notesProvider.deleteNote(note.id);
                        },
                        icon: Icon(Icons.delete_outline_outlined,
                            color: Colors.grey),
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
              ),
            ),
          );
        },
      ),
    );
  }
// Future<Color?> _showPriorityDropdown(BuildContext context, Color currentColor) async {
//     return showDialog<Color>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Select Priority"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _priorityOption(Colors.red, "High Priority"),
//               _priorityOption(Colors.orange, "Medium Priority"),
//               _priorityOption(Colors.green, "Low Priority"),
//             ],
//           ),
//         );
//       },
//     );
//   }

  // Widget _priorityOption(Color color, String label) {
  //   return ListTile(
  //     leading: Icon(Icons.flag, color: color),
  //     title: Text(label),
  //     onTap: () {
  //       Navigator.of(context).pop(color);
  //     },
  //   );
  // }
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

// import 'package:flutter/material.dart';
// import 'package:flutter_check_box_rounded/flutter_check_box_rounded.dart';
// import 'package:provider/provider.dart';
// import 'package:simple_notes_app/toDoList/providers/toDoListprovider.dart';
// import 'package:simple_notes_app/toDoList/screens/ToDoEditScreen.dart';

// class ToDoScreen extends StatefulWidget {
//   @override
//   _ToDoScreenState createState() => _ToDoScreenState();
// }

// class _ToDoScreenState extends State<ToDoScreen> {
//   String? selectedFolder;

//   @override
//   Widget build(BuildContext context) {
//     final notesProvider = Provider.of<ToDoListProvider>(context);
//     final notes = notesProvider.getNotesByFolder(selectedFolder);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//       backgroundColor: Colors.white,

//         title: Text(selectedFolder == null ? 'My Notes' : selectedFolder!),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => ToDoEditScreen(folder: selectedFolder),
//                 ),
//               );
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.folder),
//             onPressed: () async {
//               String? folderName = await _showCreateFolderDialog(context);
//               if (folderName != null && folderName.isNotEmpty) {
//                 notesProvider.addFolder(folderName);
//               }
//             },
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             Card(
//               color: Color.fromARGB(255, 253, 248, 242),
//               child: ListTile(
//                 title: Text("All Notes",
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                 onTap: () {
//                   setState(() {
//                     selectedFolder = null;
//                   });
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ),
//             ...notesProvider.folders.map((folder) => Card(
//                   color: Color.fromARGB(255, 253, 248, 242),
//                   child: ListTile(
//                     title: Text(folder,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 18)),
//                     onTap: () {
//                       setState(() {
//                         selectedFolder = folder;
//                       });
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 )),
//           ],
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: notes.length,
//         itemBuilder: (context, index) {
//           final note = notes[index];
//           return Dismissible(
//             key: ValueKey(note.id),
//             direction: DismissDirection.endToStart,
//             background: Container(
//               color: Colors.red,
//               alignment: Alignment.centerRight,
//               padding: EdgeInsets.only(right: 20),
//               child: Icon(Icons.delete, color: Colors.white),
//             ),
//             onDismissed: (direction) {
//               notesProvider.deleteNote(note.id);
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
//               child: Card(
//                 color: note.priority,
//                 child: ListTile(
//                   leading: CheckBoxRounded(
//                     borderWidth: 1.5,
//                     isChecked: note.isDone,
//                     uncheckedColor: Colors.white,
//                     checkedColor:
//                         Colors.deepPurple, // Set to your preferred color
//                     borderColor: Colors.grey,
//                     onTap: (isChecked) {
//                       setState(() {
//                         notesProvider.toggleNoteStatus(note.id, isChecked!);
//                       });
//                     },
//                   ),
//                   // Checkbox(
//                   //   value: note.isDone,
//                   //   onChanged: (bool? value) {
//                   //     setState(() {
//                   //       notesProvider.toggleNoteStatus(note.id, value ?? false);
//                   //     });
//                   //   },
//                   // ),
//                   title: Row(
//                     children: [
//                       Text(
//                         note.task,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           decoration:
//                               note.isDone ? TextDecoration.lineThrough : null,
//                         ),
//                       ),
//                       // SizedBox(width: 10),
//                       // Text(
//                       //   '${note.deadline?.toLocal().toString().split(' ')[0]}',
//                       //   style: TextStyle(fontSize: 11),
//                       // ),
//                     ],
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [ Text(
//                         '${note.deadline?.toLocal().toString().split(' ')[0]}',
//                         style: TextStyle(fontSize: 11),
//                       ),
//                       // Text(
//                       //   '${note.isDone ? "Completed" : "Pending"}',
//                       //   style: TextStyle(fontSize: 17),
//                       // ),
//                     ],
//                   ),
//                   trailing: IconButton(
//                     onPressed: () {
//                       notesProvider.deleteNote(note.id);
//                     },
//                     icon: Icon(Icons.delete_outline_outlined,color: Colors.grey,),
//                   ),
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => ToDoEditScreen(todo: note),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<String?> _showCreateFolderDialog(BuildContext context) async {
//     final TextEditingController folderController = TextEditingController();
//     return showDialog<String>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Create Folder'),
//           content: TextField(
//             controller: folderController,
//             decoration: InputDecoration(labelText: 'Folder Name'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context, null),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context, folderController.text),
//               child: Text('Create'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:simple_notes_app/toDoList/providers/toDoListprovider.dart';
// import 'package:simple_notes_app/toDoList/screens/ToDoEditScreen.dart';
// // import '../providers/notes_provider.dart';
// // import 'note_detail_screen.dart';

// class ToDoScreen extends StatefulWidget {
//   @override
//   _ToDoScreenState createState() => _ToDoScreenState();
// }

// class _ToDoScreenState extends State<ToDoScreen> {
//   String? selectedFolder;

//   @override
//   Widget build(BuildContext context) {
//     final notesProvider = Provider.of<ToDoListProvider>(context);
//     final notes = notesProvider.getNotesByFolder(selectedFolder);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(selectedFolder == null ? 'My Notes' : selectedFolder!),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       ToDoEditScreen(folder: selectedFolder),
//                 ),
//               );
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.folder),
//             onPressed: () async {
//               String? folderName = await _showCreateFolderDialog(context);
//               if (folderName != null && folderName.isNotEmpty) {
//                 notesProvider.addFolder(folderName);
//               }
//             },
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             Card( color: Color.fromARGB(255, 253, 248, 242),
//               child: ListTile(
//                 title: Text("All Notes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
//                 onTap: () {
//                   setState(() {
//                     selectedFolder = null;
//                   });
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ),
//             ...notesProvider.folders.map((folder) => Card(
//               color: Color.fromARGB(255, 253, 248, 242),
//               child: ListTile(
//                     title: Text(folder,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
//                     onTap: () {
//                       setState(() {
//                         selectedFolder = folder;
//                       });
//                       Navigator.of(context).pop();
//                     },
//                   ),
//             )),
//           ],
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: notes.length,
//         itemBuilder: (context, index) {
//           final note = notes[index];
//           return Dismissible(
//               key: ValueKey(note.id),
//               direction: DismissDirection.endToStart,
//               background: Container(
//                 color: Colors.red,
//                 alignment: Alignment.centerRight,
//                 padding: EdgeInsets.only(right: 20),
//                 child: Icon(Icons.delete, color: Colors.white),
//               ),
//               onDismissed: (direction) {
//                 notesProvider.deleteNote(note.id);
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
//                 child: Card(
//                     color: note.priority, // Apply the selected color
//                     child: ListTile(
//                       title: Row(
//                         children: [
//                           Text(note.task,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18) ,),
//                           // Spacer(flex: 1,),
//                           SizedBox(width: 10,),
//                          Text(
//                             '${note.deadline?.toLocal().toString().split(' ')[0]}', // Displaying formatted date
//                           style:TextStyle(fontSize: 11) ),],
//                       ),
//                       subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '${note.isDone}' // Displaying formatted date
//                          , style:TextStyle(fontSize: 17) ),
//                          //Created:
//                         //  Text(
//                         //     '${note.dateCreated.toLocal().toString().split(' ')[0]}', // Displaying formatted date
//                         //   style:TextStyle(fontSize: 13) ),
//                         ],
//                       ),
//                       trailing: IconButton(onPressed: (){notesProvider.deleteNote(note.id);}, icon: Icon(Icons.delete)),
//                       onTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => ToDoEditScreen(todo: note),
//                           ),
//                         );
//                       },
//                     )),
//               ));
//         },
//       ),
//     );
//   }

//   Future<String?> _showCreateFolderDialog(BuildContext context) async {
//     final TextEditingController folderController = TextEditingController();
//     return showDialog<String>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Create Folder'),
//           content: TextField(
//             controller: folderController,
//             decoration: InputDecoration(labelText: 'Folder Name'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context, null),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context, folderController.text),
//               child: Text('Create'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
