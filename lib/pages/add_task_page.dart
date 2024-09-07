import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/base/base.dart';
import 'package:todo_app/helpers/k_text.dart';
import 'package:todo_app/helpers/route.dart';
import 'package:intl/intl.dart';
import '../model/task_model.dart';

class AddTaskPage extends StatefulWidget {
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  void dispose() {
    Base.imagePickerController.selectedImagePath.value = '';
    super.dispose();
  }

  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 20),
          child: ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                Base.taskController.addTask(
                  Task(
                    title: titleController.text,
                    dueTime: Base.taskController.selectedDateTime.value,
                    imagePath:
                        Base.imagePickerController.selectedImagePath.value,
                  ),
                );

                back(); // Go back after adding task
              } else {
                Get.snackbar('Warning', 'please fill all required fields',
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent, // Button color
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: KText(
              text: 'Add Task',
              bold: true,
              color: Colors.white,
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          iconTheme: IconThemeData(
            color: Colors.white, // Change this to your desired color
          ),
          title: KText(
            text: 'Add Task',
            color: Colors.white,
            bold: true,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Task Title'),
                ),
                SizedBox(height: 10),
                //show Selected Date & Time
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Selected Date & Time: ',
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.black,
                            fontSize: 15,
                            height: 1.2),
                      ),
                      TextSpan(
                        text: DateFormat('yyyy-MM-dd hh:mm:ss a')
                            .format(Base.taskController.selectedDateTime.value),
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Pick Date & Time
                ElevatedButton(
                  onPressed: () {
                    Base.taskController.selectDateTime(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Button color
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: KText(
                    text: 'Pick Date & Time',
                    bold: true,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Obx(() {
                  return Base.imagePickerController.selectedImagePath.value ==
                          ''
                      ? KText(text: 'No image selected')
                      : Image.file(
                          File(Base
                              .imagePickerController.selectedImagePath.value),
                          width: 200,
                          height: 200,
                        );
                }),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Base.imagePickerController
                            .pickImage(ImageSource.camera);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, // Button color
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: KText(
                        text: 'Capture Image',
                        color: Colors.white,
                        bold: true,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Base.imagePickerController
                            .pickImage(ImageSource.gallery);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, // Button color
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: KText(
                        text: 'Select from Gallery',
                        color: Colors.white,
                        bold: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
