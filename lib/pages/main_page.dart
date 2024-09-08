import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/component/left_drawer.dart';
import 'package:todo_app/pages/add_task_page.dart';
import 'package:todo_app/pages/task_details_page.dart';
import '../base/base.dart';
import '../helpers/k_text.dart';
import '../helpers/route.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    Base.connectivityService; // Initialize connectivity service
  }

  @override
  Widget build(BuildContext context) {
    // final platform = Theme.of(context).platform;
    return Scaffold(
      drawer: LeftDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
        title: KText(
          text: 'To-Do List',
          color: Colors.white,
          bold: true,
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              push(AddTaskPage());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (Base.taskController.tasks.isEmpty) {
          return Center(
              child: Center(child: KText(text: 'No tasks available')));
        }
        return ListView.builder(
          itemCount: Base.taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = Base.taskController.tasks[index];
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: Colors.black12,
                    )
                  ],
                ),
                child: ListTile(
                  trailing: task.imagePath == null
                      ? SizedBox()
                      : Image.file(File(task.imagePath!)),
                  title: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Title: ',
                          style: TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.black,
                              fontSize: 16,
                              height: 1.2),
                        ),
                        TextSpan(
                          text: task.title,
                          style: TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.2),
                        )
                      ],
                    ),
                  ),
                  subtitle: KText(
                      text:
                          'Due Time: ${DateFormat('yyyy-MM-dd hh:mm a').format(task.dueTime)}'),
                  onTap: () {
                    push(TaskDetailPage(task: task));
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
