import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/base/base.dart';
import 'package:todo_app/helpers/k_log.dart';
import 'package:todo_app/helpers/k_text.dart';
import 'package:todo_app/helpers/route.dart';

import '../model/task_model.dart';

class AddTaskPage extends StatefulWidget {
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleController = TextEditingController();
  DateTime? selectedDueTime;
  String? imagePath;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = pickedFile?.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                selectedDueTime = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
              },
              child: Text('Select Due Date'),
            ),
            KText(text: selectedDueTime.toString()),
            SizedBox(height: 10),
            TextButton(
              onPressed: pickImage,
              child: Text('Pick Image'),
            ),
            imagePath == null ? SizedBox() : Image.file(File(imagePath!)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    selectedDueTime != null) {
                  Base.taskController.addTask(Task(
                    title: titleController.text,
                    dueTime: selectedDueTime!,
                    imagePath: imagePath,
                  ));
                  kLog(imagePath);
                  kLog(selectedDueTime);
                  back(); // Go back after adding task
                }
              },
              child: Text('Add Tasked'),
            ),
          ],
        ),
      ),
    );
  }
}
