import 'package:flutter/material.dart';

void showDeleteConfirmationDialog(
    BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Delete Confirmation"),
        content: Text("Are you sure you want to delete this item?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Cancel", style: TextStyle(color: Colors.black)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              onConfirm(); // Execute the delete action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Set the button color to red
            ),
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
