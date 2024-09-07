import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_app/helpers/k_text.dart';
import 'package:todo_app/helpers/route.dart';

import '../base/base.dart';
import '../model/task_model.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;

  TaskDetailPage({required this.task});

  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = task.title;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
        title: KText(
          text: 'Task Details',
          color: Colors.white,
          bold: true,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            onPressed: () {
              Base.taskController.deleteTask(task);
              back();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Task Title',
                labelStyle: TextStyle(
                    fontFamily: 'Manrope Regular',
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'write here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            task.imagePath == null
                ? KText(text: 'No image')
                : Image.file(
                    File(task.imagePath!),
                    width: 200,
                    height: 200,
                  ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                task.title = titleController.text;
                Base.taskController.updateTask(task);
                back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Button color
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: KText(
                text: 'Save Changes',
                bold: true,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
