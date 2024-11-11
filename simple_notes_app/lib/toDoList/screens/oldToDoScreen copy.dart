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

//   Map<String, Color> priorityOptions = {
//     'High Priority': Colors.red,
//     'Medium Priority': Colors.orange,
//     'Low Priority': Colors.green,
//   };

//   @override
//   Widget build(BuildContext context) {
//     final notesProvider = Provider.of<ToDoListProvider>(context);
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
//               child: 
//               // Card(
//               //   color: Colors.white,
//               //   child: ListTile(
//               //     leading: CheckBoxRounded(
//               //       borderWidth: 1.5,
//               //       isChecked: note.isDone,
//               //       uncheckedColor: Colors.white,
//               //       checkedColor: Colors.deepPurple,
//               //       borderColor: Colors.grey,
//               //       onTap: (isChecked) {
//               //         setState(() {
//               //           notesProvider.toggleNoteStatus(note.id, isChecked!);
//               //         });
//               //       },
//               //     ),
//               //     title: Flexible(
//               //       // Change Flexible to Expanded
//               //       child: Row(
//               //         children: [
//               //           // Text(
//               //           //   note.task,
//               //           //   style: TextStyle(
//               //           //     fontWeight: FontWeight.bold,
//               //           //     fontSize: 18,
//               //           //     decoration: note.isDone ? TextDecoration.lineThrough : null,
//               //           //   ),
//               //           //   overflow: TextOverflow.ellipsis,  // Avoid overflow when text is too long
//               //           // ),
//               //           Expanded(
//               //             child: Text(
//               //               note.task,
//               //               style: TextStyle(
//               //                 fontWeight: FontWeight.bold,
//               //                 fontSize: 18,
//               //               ),
//               //               overflow:
//               //                   TextOverflow.ellipsis, // Prevents overflow
//               //             ),
//               //           ),
//               //           // Spacer(flex: 1,),
//               //           // SizedBox(width: 50,),
//               //           DropdownButton<Color>(
//               //             value: priorityOptions.containsValue(note.priority)
//               //                 ? note.priority
//               //                 : null,
//               //             icon: Icon(Icons.flag, color: note.priority),
//               //             underline: Container(),
//               //             items: priorityOptions.entries.map((entry) {
//               //               return DropdownMenuItem<Color>(
//               //                 value: entry.value,
//               //                 child: Row(
//               //                   children: [
//               //                     Icon(Icons.flag, color: entry.value),
//               //                     SizedBox(width: 8),
//               //                     Text(entry.key),
//               //                   ],
//               //                 ),
//               //               );
//               //             }).toList(),
//               //             onChanged: (Color? newColor) {
//               //               if (newColor != null) {
//               //                 notesProvider.updateNote(
//               //                   note.id,
//               //                   note.task,
//               //                   note.isDone,
//               //                   note.folder,
//               //                   newColor,
//               //                   note.deadline ?? DateTime.now(),
//               //                 );
//               //               }
//               //             },
//               //           ),
//               //           // SizedBox(width: 10), // Add some space between the flag and delete icon
//               //           IconButton(
//               //             onPressed: () {
//               //               notesProvider.deleteNote(note.id);
//               //             },
//               //             icon: Icon(Icons.delete_outline_outlined,
//               //                 color: Colors.grey),
//               //           ),
//               //         ],
//               //       ),
//               //     ),
                  
//               //     subtitle: Column(
//               //       crossAxisAlignment: CrossAxisAlignment.start,
//               //       children: [
//               //         Text(
//               //           '${note.deadline?.toLocal().toString().split(' ')[0]}',
//               //           style: TextStyle(fontSize: 11),
//               //         ),
//               //       ],
//               //     ),
//               //     // trailing: Container(
//               //     //   constraints: BoxConstraints(maxWidth: 150), // Limit the width of the trailing part
//               //     //   child: Row(
//               //     //     mainAxisSize: MainAxisSize.min,  // Ensure the row takes up only necessary space
//               //     //     children: [
//               //     //       // DropdownButton for priority color
//               //     //       SizedBox(
//               //     //         width: 80, // Width for the DropdownButton
//               //     //         child: DropdownButton<Color>(
//               //     //           value: priorityOptions.containsValue(note.priority) ? note.priority : null,
//               //     //           icon: Icon(Icons.flag, color: note.priority),
//               //     //           underline: Container(),
//               //     //           items: priorityOptions.entries.map((entry) {
//               //     //             return DropdownMenuItem<Color>(
//               //     //               value: entry.value,
//               //     //               child: Row(
//               //     //                 children: [
//               //     //                   Icon(Icons.flag, color: entry.value),
//               //     //                   SizedBox(width: 8),
//               //     //                   Text(entry.key),
//               //     //                 ],
//               //     //               ),
//               //     //             );
//               //     //           }).toList(),
//               //     //           onChanged: (Color? newColor) {
//               //     //             if (newColor != null) {
//               //     //               notesProvider.updateNote(
//               //     //                 note.id,
//               //     //                 note.task,
//               //     //                 note.isDone,
//               //     //                 note.folder,
//               //     //                 newColor,
//               //     //                 note.deadline ?? DateTime.now(),
//               //     //               );
//               //     //             }
//               //     //           },
//               //     //         ),
//               //     //       ),
//               //     //       SizedBox(width: 10), // Add some space between the flag and delete icon
//               //     //       IconButton(
//               //     //         onPressed: () {
//               //     //           notesProvider.deleteNote(note.id);
//               //     //         },
//               //     //         icon: Icon(Icons.delete_outline_outlined, color: Colors.grey),
//               //     //       ),
//               //     //     ],
//               //     //   ),
//               //     // ),
//               //     onTap: () {
//               //       Navigator.of(context).push(
//               //         MaterialPageRoute(
//               //           builder: (context) => ToDoEditScreen(todo: note),
//               //         ),
//               //       );
//               //     },
//               //   ),
//               // ),
            
// //             Card(
// //           elevation: 5,
// //           margin: EdgeInsets.all(10),
// //           child: Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// // CheckBoxRounded(
// //       borderWidth: 1.5,
// //       isChecked: note.isDone,
// //       uncheckedColor: Colors.white,
// //       checkedColor: Colors.deepPurple,
// //       borderColor: Colors.grey,
// //       onTap: (isChecked) {
// //         setState(() {
// //           notesProvider.toggleNoteStatus(note.id, isChecked!);
// //         });
// //       },
// //     ),                Expanded(
// //                   child:
// //                     Text(
// // note.task,                    overflow: TextOverflow.ellipsis, // Handle overflow
// // style: TextStyle(
// //                   fontWeight: FontWeight.bold,
// //                   fontSize: 18,
// //                   decoration: note.isDone ? TextDecoration.lineThrough : null,
// //                 ),                  ),
// //                 ),
// //                 // Icon(Icons.favorite, size: 30),
                
// // IconButton(
// //           onPressed: () {
// //             notesProvider.deleteNote(note.id);
// //           },
// //           icon: Icon(Icons.delete_outline_outlined, color: Colors.grey),
// //         ),              ],
// //             ),
// //           ),
// //         ),
      
//               Card(
//   color: Colors.white,
//   child: ListTile(
//     leading: CheckBoxRounded(
//       borderWidth: 1.5,
//       isChecked: note.isDone,
//       uncheckedColor: Colors.white,
//       checkedColor: Colors.deepPurple,
//       borderColor: Colors.grey,
//       onTap: (isChecked) {
//         setState(() {
//           notesProvider.toggleNoteStatus(note.id, isChecked!);
//         });
//       },
//     ),
//     title: Row(
//       children: [
//         Expanded(
//           child: Text(
//             note.task,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//               decoration: note.isDone ? TextDecoration.lineThrough : null,
//             ),
//             overflow: TextOverflow.ellipsis, // Prevents overflow
//           ),
//         ),
//         PopupMenuButton<Color>(
//   icon: Icon(Icons.flag, color: note.priority, size: 24), // Icon size
//   padding: EdgeInsets.zero, // Remove any extra padding
//   onSelected: (Color newColor) {
//     notesProvider.updateNote(
//       note.id,
//       note.task,
//       note.isDone,
//       note.folder,
//       newColor,
//       note.deadline ?? DateTime.now(),
//     );
//   },
//   itemBuilder: (BuildContext context) {
//     return priorityOptions.entries.map((entry) {
//       return PopupMenuItem<Color>(
//         value: entry.value,
//         child: Row(
//           children: [
//             Icon(Icons.flag, color: entry.value, size: 24), // Matching icon size
//             SizedBox(width: 8),
//             Text(entry.key),
//           ],
//         ),
//       );
//     }).toList();
//   },
// )
// ,// Assuming the 'note' object has a 'priority' field to store the color.
// PopupMenuButton<Color>(
//   icon: Icon(Icons.flag, color: note.priority ?? Colors.green, size: 24), // Default to green
//   padding: EdgeInsets.zero, // Remove any extra padding
//   onSelected: (Color newColor) {
//     // Update the color for the specific task (note)
//     setState(() {
//       note.priority = newColor; // Update the color for this specific task
//     });

//     // Update the note with the new color
//     notesProvider.updateNote(
//       note.id,
//       note.task,
//       note.isDone,
//       note.folder,
//       note.priority, // Send the updated priority color
//       note.deadline ?? DateTime.now(),
//     );
//   },
//   itemBuilder: (BuildContext context) {
//     return priorityOptions.entries.map((entry) {
//       return PopupMenuItem<Color>(
//         value: entry.value,
//         child: Row(
//           children: [
//             Icon(Icons.flag, color: entry.value, size: 24), // Display each color option
//             SizedBox(width: 8),
//             Text(entry.key),
//           ],
//         ),
//       );
//     }).toList();
//   },
// )
// ,
//         // DropdownButton<Color>(
//         //   // value: priorityOptions.containsValue(note.priority)
//         //   //     ? note.priority
//         //   //     : null,
//         //   icon: Icon(Icons.flag, color: note.priority),
//         //   underline: Container(),
//         //   items: priorityOptions.entries.map((entry) {
//         //     return DropdownMenuItem<Color>(
//         //       value: entry.value,
//         //       child: Row(
//         //         children: [
//         //           Icon(Icons.flag, color: entry.value),
//         //           SizedBox(width: 8),
//         //           Text(entry.key),
//         //         ],
//         //       ),
//         //     );
//         //   }).toList(),
//         //   onChanged: (Color? newColor) {
//         //     if (newColor != null) {
//         //       notesProvider.updateNote(
//         //         note.id,
//         //         note.task,
//         //         note.isDone,
//         //         note.folder,
//         //         newColor,
//         //         note.deadline ?? DateTime.now(),
//         //       );
//         //     }
//         //   },
//         // ),
//                   IconButton(
//                   onPressed: () {
//         notesProvider.deleteNote(note.id);
//                   },
//                   icon: Icon(Icons.delete_outline_outlined, color: Colors.grey),
//                 ),
        
//       ],
//     ),
//     subtitle: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           '${note.deadline?.toLocal().toString().split(' ')[0]}',
//           style: TextStyle(fontSize: 11),
//         ),
//       ],
//     ),
//     onTap: () {
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => ToDoEditScreen(todo: note),
//         ),
//       );
//     },
//   ),
// )


// // Card(
// //   color: Colors.white,
// //   child: ListTile(
// //     leading: CheckBoxRounded(
// //       borderWidth: 1.5,
// //       isChecked: note.isDone,
// //       uncheckedColor: Colors.white,
// //       checkedColor: Colors.deepPurple,
// //       borderColor: Colors.grey,
// //       onTap: (isChecked) {
// //         setState(() {
// //           notesProvider.toggleNoteStatus(note.id, isChecked!);
// //         });
// //       },
// //     ),
// //     title: Flexible(
// //       child: Text(
// //         note.task,
// //         style: TextStyle(
// //           fontWeight: FontWeight.bold,
// //           fontSize: 18,
// //           decoration: note.isDone ? TextDecoration.lineThrough : null,
// //         ),
// //         overflow: TextOverflow.ellipsis, // Avoid overflow when text is too long
// //       ),
// //     ),
// //     subtitle: Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           '${note.deadline?.toLocal().toString().split(' ')[0]}',
// //           style: TextStyle(fontSize: 11),
// //         ),
// //       ],
// //     ),
// //     trailing: Container(
// //       width: 150,  // Set width to avoid overflow
// //       child: Row(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           // DropdownButton for priority color
// //           SizedBox(
// //             width: 80, // Limit the width of the DropdownButton
// //             child: DropdownButton<Color>(
// //               value: priorityOptions.containsValue(note.priority) ? note.priority : null,
// //               icon: Icon(Icons.flag, color: note.priority),
// //               underline: Container(),
// //               items: priorityOptions.entries.map((entry) {
// //                 return DropdownMenuItem<Color>(
// //                   value: entry.value,
// //                   child: Row(
// //                     children: [
// //                       Icon(Icons.flag, color: entry.value),
// //                       SizedBox(width: 8),
// //                       Text(entry.key),
// //                     ],
// //                   ),
// //                 );
// //               }).toList(),
// //               onChanged: (Color? newColor) {
// //                 if (newColor != null) {
// //                   notesProvider.updateNote(
// //                     note.id,
// //                     note.task,
// //                     note.isDone,
// //                     note.folder,
// //                     newColor,
// //                     note.deadline ?? DateTime.now(),
// //                   );
// //                 }
// //               },
// //             ),
// //           ),
// //           IconButton(
// //             onPressed: () {
// //               notesProvider.deleteNote(note.id);
// //             },
// //             icon: Icon(Icons.delete_outline_outlined, color: Colors.grey),
// //           ),
// //         ],
// //       ),
// //     ),
// //     onTap: () {
// //       Navigator.of(context).push(
// //         MaterialPageRoute(
// //           builder: (context) => ToDoEditScreen(todo: note),
// //         ),
// //       );
// //     },
// //   ),
// // ),
//               // child: Card(
//               //   color: Colors.white,
//               //   // color: note.priority,
//               //   child: ListTile(
//               //     leading: CheckBoxRounded(
//               //       borderWidth: 1.5,
//               //       isChecked: note.isDone,
//               //       uncheckedColor: Colors.white,
//               //       checkedColor: Colors.deepPurple,
//               //       borderColor: Colors.grey,
//               //       onTap: (isChecked) {
//               //         setState(() {
//               //           notesProvider.toggleNoteStatus(note.id, isChecked!);
//               //         });
//               //       },
//               //     ),
//               //     title: Row(
//               //       children: [
//               //         Text(
//               //           note.task,
//               //           style: TextStyle(
//               //             fontWeight: FontWeight.bold,
//               //             fontSize: 18,
//               //             decoration:
//               //                 note.isDone ? TextDecoration.lineThrough : null,
//               //           ),
//               //         ),
//               //       ],
//               //     ),
//               //     subtitle: Column(
//               //       crossAxisAlignment: CrossAxisAlignment.start,
//               //       children: [
//               //         Text(
//               //           '${note.deadline?.toLocal().toString().split(' ')[0]}',
//               //           style: TextStyle(fontSize: 11),
//               //         ),
//               //       ],
//               //     ),
//               //     trailing: Row(
//               //       mainAxisSize: MainAxisSize.min,
//               //       children: [
//               //         DropdownButton<Color>(
//               //           // value: priorityOptions.containsValue(note.priority) ? note.priority : null, // Only assign if it's a valid option
//               //           icon: Icon(Icons.flag,
//               //               color: note.priority), // Color of the flag icon
//               //           underline: Container(), // No underline
//               //           items: priorityOptions.entries.map((entry) {
//               //             return DropdownMenuItem<Color>(
//               //               value: entry.value, // The actual color to set
//               //               child: Row(
//               //                 children: [
//               //                   Icon(Icons.flag,
//               //                       color: entry
//               //                           .value), // Display the color of the flag
//               //                   SizedBox(width: 8),
//               //                   Text(entry
//               //                       .key), // Display the label for the priority
//               //                 ],
//               //               ),
//               //             );
//               //           }).toList(),
//               //           onChanged: (Color? newColor) {
//               //             if (newColor != null) {
//               //               notesProvider.updateNote(
//               //                 note.id,
//               //                 note.task,
//               //                 note.isDone,
//               //                 note.folder,
//               //                 newColor, // Update only the priority color
//               //                 note.deadline ?? DateTime.now(),
//               //               );
//               //             }
//               //           },
//               //         ),
//               //         IconButton(
//               //           onPressed: () {
//               //             notesProvider.deleteNote(note.id);
//               //           },
//               //           icon: Icon(Icons.delete_outline_outlined,
//               //               color: Colors.grey),
//               //         ),
//               //       ],
//               //     ),
//               //     onTap: () {
//               //       Navigator.of(context).push(
//               //         MaterialPageRoute(
//               //           builder: (context) => ToDoEditScreen(todo: note),
//               //         ),
//               //       );
//               //     },
//               //   ),
//               // ),
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








// // import 'package:flutter/material.dart';
// // import 'package:flutter_check_box_rounded/flutter_check_box_rounded.dart';
// // import 'package:provider/provider.dart';
// // import 'package:simple_notes_app/toDoList/providers/toDoListprovider.dart';
// // import 'package:simple_notes_app/toDoList/screens/ToDoEditScreen.dart';

// // class ToDoScreen extends StatefulWidget {
// //   @override
// //   _ToDoScreenState createState() => _ToDoScreenState();
// // }

// // class _ToDoScreenState extends State<ToDoScreen> {
// //   String? selectedFolder;

// //   @override
// //   Widget build(BuildContext context) {
// //     final notesProvider = Provider.of<ToDoListProvider>(context);
// //     final notes = notesProvider.getNotesByFolder(selectedFolder);

// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //       backgroundColor: Colors.white,

// //         title: Text(selectedFolder == null ? 'My Notes' : selectedFolder!),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.add),
// //             onPressed: () {
// //               Navigator.of(context).push(
// //                 MaterialPageRoute(
// //                   builder: (context) => ToDoEditScreen(folder: selectedFolder),
// //                 ),
// //               );
// //             },
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.folder),
// //             onPressed: () async {
// //               String? folderName = await _showCreateFolderDialog(context);
// //               if (folderName != null && folderName.isNotEmpty) {
// //                 notesProvider.addFolder(folderName);
// //               }
// //             },
// //           ),
// //         ],
// //       ),
// //       drawer: Drawer(
// //         child: ListView(
// //           children: [
// //             Card(
// //               color: Color.fromARGB(255, 253, 248, 242),
// //               child: ListTile(
// //                 title: Text("All Notes",
// //                     style:
// //                         TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
// //                 onTap: () {
// //                   setState(() {
// //                     selectedFolder = null;
// //                   });
// //                   Navigator.of(context).pop();
// //                 },
// //               ),
// //             ),
// //             ...notesProvider.folders.map((folder) => Card(
// //                   color: Color.fromARGB(255, 253, 248, 242),
// //                   child: ListTile(
// //                     title: Text(folder,
// //                         style: TextStyle(
// //                             fontWeight: FontWeight.bold, fontSize: 18)),
// //                     onTap: () {
// //                       setState(() {
// //                         selectedFolder = folder;
// //                       });
// //                       Navigator.of(context).pop();
// //                     },
// //                   ),
// //                 )),
// //           ],
// //         ),
// //       ),
// //       body: ListView.builder(
// //         itemCount: notes.length,
// //         itemBuilder: (context, index) {
// //           final note = notes[index];
// //           return Dismissible(
// //             key: ValueKey(note.id),
// //             direction: DismissDirection.endToStart,
// //             background: Container(
// //               color: Colors.red,
// //               alignment: Alignment.centerRight,
// //               padding: EdgeInsets.only(right: 20),
// //               child: Icon(Icons.delete, color: Colors.white),
// //             ),
// //             onDismissed: (direction) {
// //               notesProvider.deleteNote(note.id);
// //             },
// //             child: Padding(
// //               padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
// //               child: Card(
// //                 color: note.priority,
// //                 child: ListTile(
// //                   leading: CheckBoxRounded(
// //                     borderWidth: 1.5,
// //                     isChecked: note.isDone,
// //                     uncheckedColor: Colors.white,
// //                     checkedColor:
// //                         Colors.deepPurple, // Set to your preferred color
// //                     borderColor: Colors.grey,
// //                     onTap: (isChecked) {
// //                       setState(() {
// //                         notesProvider.toggleNoteStatus(note.id, isChecked!);
// //                       });
// //                     },
// //                   ),
// //                   // Checkbox(
// //                   //   value: note.isDone,
// //                   //   onChanged: (bool? value) {
// //                   //     setState(() {
// //                   //       notesProvider.toggleNoteStatus(note.id, value ?? false);
// //                   //     });
// //                   //   },
// //                   // ),
// //                   title: Row(
// //                     children: [
// //                       Text(
// //                         note.task,
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 18,
// //                           decoration:
// //                               note.isDone ? TextDecoration.lineThrough : null,
// //                         ),
// //                       ),
// //                       // SizedBox(width: 10),
// //                       // Text(
// //                       //   '${note.deadline?.toLocal().toString().split(' ')[0]}',
// //                       //   style: TextStyle(fontSize: 11),
// //                       // ),
// //                     ],
// //                   ),
// //                   subtitle: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [ Text(
// //                         '${note.deadline?.toLocal().toString().split(' ')[0]}',
// //                         style: TextStyle(fontSize: 11),
// //                       ),
// //                       // Text(
// //                       //   '${note.isDone ? "Completed" : "Pending"}',
// //                       //   style: TextStyle(fontSize: 17),
// //                       // ),
// //                     ],
// //                   ),
// //                   trailing: IconButton(
// //                     onPressed: () {
// //                       notesProvider.deleteNote(note.id);
// //                     },
// //                     icon: Icon(Icons.delete_outline_outlined,color: Colors.grey,),
// //                   ),
// //                   onTap: () {
// //                     Navigator.of(context).push(
// //                       MaterialPageRoute(
// //                         builder: (context) => ToDoEditScreen(todo: note),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Future<String?> _showCreateFolderDialog(BuildContext context) async {
// //     final TextEditingController folderController = TextEditingController();
// //     return showDialog<String>(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text('Create Folder'),
// //           content: TextField(
// //             controller: folderController,
// //             decoration: InputDecoration(labelText: 'Folder Name'),
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () => Navigator.pop(context, null),
// //               child: Text('Cancel'),
// //             ),
// //             TextButton(
// //               onPressed: () => Navigator.pop(context, folderController.text),
// //               child: Text('Create'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:simple_notes_app/toDoList/providers/toDoListprovider.dart';
// // import 'package:simple_notes_app/toDoList/screens/ToDoEditScreen.dart';
// // // import '../providers/notes_provider.dart';
// // // import 'note_detail_screen.dart';

// // class ToDoScreen extends StatefulWidget {
// //   @override
// //   _ToDoScreenState createState() => _ToDoScreenState();
// // }

// // class _ToDoScreenState extends State<ToDoScreen> {
// //   String? selectedFolder;

// //   @override
// //   Widget build(BuildContext context) {
// //     final notesProvider = Provider.of<ToDoListProvider>(context);
// //     final notes = notesProvider.getNotesByFolder(selectedFolder);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(selectedFolder == null ? 'My Notes' : selectedFolder!),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.add),
// //             onPressed: () {
// //               Navigator.of(context).push(
// //                 MaterialPageRoute(
// //                   builder: (context) =>
// //                       ToDoEditScreen(folder: selectedFolder),
// //                 ),
// //               );
// //             },
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.folder),
// //             onPressed: () async {
// //               String? folderName = await _showCreateFolderDialog(context);
// //               if (folderName != null && folderName.isNotEmpty) {
// //                 notesProvider.addFolder(folderName);
// //               }
// //             },
// //           ),
// //         ],
// //       ),
// //       drawer: Drawer(
// //         child: ListView(
// //           children: [
// //             Card( color: Color.fromARGB(255, 253, 248, 242),
// //               child: ListTile(
// //                 title: Text("All Notes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
// //                 onTap: () {
// //                   setState(() {
// //                     selectedFolder = null;
// //                   });
// //                   Navigator.of(context).pop();
// //                 },
// //               ),
// //             ),
// //             ...notesProvider.folders.map((folder) => Card(
// //               color: Color.fromARGB(255, 253, 248, 242),
// //               child: ListTile(
// //                     title: Text(folder,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
// //                     onTap: () {
// //                       setState(() {
// //                         selectedFolder = folder;
// //                       });
// //                       Navigator.of(context).pop();
// //                     },
// //                   ),
// //             )),
// //           ],
// //         ),
// //       ),
// //       body: ListView.builder(
// //         itemCount: notes.length,
// //         itemBuilder: (context, index) {
// //           final note = notes[index];
// //           return Dismissible(
// //               key: ValueKey(note.id),
// //               direction: DismissDirection.endToStart,
// //               background: Container(
// //                 color: Colors.red,
// //                 alignment: Alignment.centerRight,
// //                 padding: EdgeInsets.only(right: 20),
// //                 child: Icon(Icons.delete, color: Colors.white),
// //               ),
// //               onDismissed: (direction) {
// //                 notesProvider.deleteNote(note.id);
// //               },
// //               child: Padding(
// //                 padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
// //                 child: Card(
// //                     color: note.priority, // Apply the selected color
// //                     child: ListTile(
// //                       title: Row(
// //                         children: [
// //                           Text(note.task,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18) ,),
// //                           // Spacer(flex: 1,),
// //                           SizedBox(width: 10,),
// //                          Text(
// //                             '${note.deadline?.toLocal().toString().split(' ')[0]}', // Displaying formatted date
// //                           style:TextStyle(fontSize: 11) ),],
// //                       ),
// //                       subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             '${note.isDone}' // Displaying formatted date
// //                          , style:TextStyle(fontSize: 17) ),
// //                          //Created:
// //                         //  Text(
// //                         //     '${note.dateCreated.toLocal().toString().split(' ')[0]}', // Displaying formatted date
// //                         //   style:TextStyle(fontSize: 13) ),
// //                         ],
// //                       ),
// //                       trailing: IconButton(onPressed: (){notesProvider.deleteNote(note.id);}, icon: Icon(Icons.delete)),
// //                       onTap: () {
// //                         Navigator.of(context).push(
// //                           MaterialPageRoute(
// //                             builder: (context) => ToDoEditScreen(todo: note),
// //                           ),
// //                         );
// //                       },
// //                     )),
// //               ));
// //         },
// //       ),
// //     );
// //   }

// //   Future<String?> _showCreateFolderDialog(BuildContext context) async {
// //     final TextEditingController folderController = TextEditingController();
// //     return showDialog<String>(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text('Create Folder'),
// //           content: TextField(
// //             controller: folderController,
// //             decoration: InputDecoration(labelText: 'Folder Name'),
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () => Navigator.pop(context, null),
// //               child: Text('Cancel'),
// //             ),
// //             TextButton(
// //               onPressed: () => Navigator.pop(context, folderController.text),
// //               child: Text('Create'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }
