import 'package:flutter/material.dart';

class TaskDeadlinePicker extends StatefulWidget {
  @override
  _TaskDeadlinePickerState createState() => _TaskDeadlinePickerState();
}

class _TaskDeadlinePickerState extends State<TaskDeadlinePicker> {
  DateTime? _selectedDeadline;

  // Function to pick a date
  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDeadline = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: _pickDate,
          child: Text(
            _selectedDeadline == null
                ? 'Pick a deadline'
                : 'Deadline: ${_selectedDeadline.toString()}',
          ),
        ),
        // Other widgets to save or submit the task details
      ],
    );
  }
}
