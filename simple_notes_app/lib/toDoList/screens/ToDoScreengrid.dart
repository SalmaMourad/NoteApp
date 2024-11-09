// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:simple_notes_app/screens/delete.dart';
// // import '../providers/notes_provider.dart';
// import 'ToDoEditScreen.dart';

// class NotesListScreen extends StatefulWidget {
//   @override
//   _NotesListScreenState createState() => _NotesListScreenState();
// }

// class _NotesListScreenState extends State<NotesListScreen> {
//   String? selectedFolder;

//   @override
//   Widget build(BuildContext context) {
//     final notesProvider = Provider.of<NotesProvider>(context);
//     final notes = notesProvider.getNotesByFolder(selectedFolder);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
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
//             SizedBox(height: 10,),
//             Card(
//               color: Color.fromARGB(255, 253, 248, 242),
//               child: ListTile(
//                 title: Text("My Notes",
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
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           itemCount: notes.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, // Two columns
//             crossAxisSpacing: 10, // Space between columns
//             mainAxisSpacing: 10, // Space between rows
//             childAspectRatio: 4 / 4, // Aspect ratio for each card
//           ),
//           itemBuilder: (context, index) {
//             final note = notes[index];
//             return Dismissible(
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
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => ToDoEditScreen(todo: note),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 200,
//                   height: 250,
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: note.color,
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.5),
//                         blurRadius: 6,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Row(
//                       //   children: [
//                       //     Text(
//                       //       note.title,
//                       //       style: TextStyle(
//                       //         fontSize: 18,
//                       //         fontWeight: FontWeight.bold,
//                       //         color: Colors.black,
//                       //       ),
//                       //     ),
//                       //     Spacer(flex: 1,),
//                       //      Text(
//                       //   note.dateCreated.toLocal().toString().split(' ')[0],
//                       //   style: TextStyle(color: const Color.fromARGB(255, 100, 100, 100), fontSize: 12),
//                       // ),
//                       //   ],
//                       // ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               note.title,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                               ),
//                               overflow:
//                                   TextOverflow.ellipsis, // Prevents overflow
//                             ),
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             note.dateCreated.toLocal().toString().split(' ')[0],
//                             style: TextStyle(fontSize: 11),
//                             overflow:
//                                 TextOverflow.ellipsis, // Prevents overflow
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 8),
//                       Text(
//                         note.description,
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                         style:
//                             TextStyle(color: Color.fromARGB(255, 45, 45, 45)),
//                       ),
//                       Spacer(),
//                       // Text(
//                       //   note.dateCreated.toLocal().toString().split(' ')[0],
//                       //   style: TextStyle(color: Colors.grey, fontSize: 12),
//                       // ),
//                       Row(
//                         children: [
//                           Spacer(
//                             flex: 1,
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               showDeleteConfirmationDialog(context, () {
//                                 notesProvider.deleteNote(note.id);
//                                 // Perform delete action here
//                                 print("Item deleted");
//                               });
//                             },
//                             // onPressed: () {
//                             //   notesProvider.deleteNote(note.id);
//                             // },
//                             icon: Icon(Icons.delete,
//                                 color: const Color.fromARGB(255, 45, 45, 45)),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
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
