import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        title: Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
            Base.taskController.deleteTask(task);
              Get.back();
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
              decoration: InputDecoration(labelText: 'Task Title'),
            ),

               task.imagePath!=null
                  ? Text('No image')
                  : Image.file(
                File(task.imagePath!),
                width: 200,
                height: 200,

            ),
            ElevatedButton(
              onPressed: () {
                task.title = titleController.text;
                Base.taskController.updateTask(task);
                Get.back();  // Return after updating
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
