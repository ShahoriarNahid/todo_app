import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/helpers/route.dart';
import 'package:todo_app/pages/add_task_page.dart';
import 'package:todo_app/services/notification_service.dart';

import '../base/base.dart';

class TaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              push(AddTaskPage());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (Base.taskController.tasks.isEmpty) {
          return Center(child: Text('No tasks available'));
        }
        return ListView.builder(
          itemCount: Base.taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = Base.taskController.tasks[index];
            return ListTile(
              trailing: task.imagePath == null
                  ? SizedBox()
                  : Image.file(File(task.imagePath!)),
              title: Text(task.title),
              subtitle: Text('Due: ${task.dueTime}'),
              leading: Checkbox(
                value: task.isDone,
                onChanged: (val) {
                  Base.taskController.toggleTaskCompletion(task);
                },
              ),
              onTap: () {
                NotificationService.showSimpleNotification(
                    title: task.title,
                    body: 'This is a simple notification',
                    payload: 'This is simple data');
                // push(TaskDetailPage(task: task));
              },
            );
          },
        );
      }),
    );
  }
}
