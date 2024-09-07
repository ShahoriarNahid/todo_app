import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/base/base.dart';
import 'package:todo_app/helpers/k_log.dart';
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
    super.dispose();
  }

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
    return Obx(
      () => Scaffold(
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
                ElevatedButton(
                  onPressed: () {
                    pickImage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Button color
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: KText(
                    text: 'Pick Image',
                    bold: true,
                    color: Colors.white,
                  ),
                ),

                // TextButton(
                //   onPressed: () async {
                //     selectedDueTime = await showDatePicker(
                //       context: context,
                //       initialDate: DateTime.now(),
                //       firstDate: DateTime(2000),
                //       lastDate: DateTime(2101),
                //     );
                //   },
                //   child: Text('Select Due Date'),
                // ),
                // if (selectedDueTime != null)
                //   KText(
                //       text: (DateFormat('yyyy-MM-dd HH:mm:ss')
                //           .format(selectedDueTime!))),

                SizedBox(height: 10),

                imagePath == null
                    ? SizedBox()
                    : SizedBox(
                        height: 200,
                        width: Get.width,
                        child: ClipRRect(
                          child: Image.file(
                            File(imagePath!),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                ElevatedButton(
                  onPressed: () {
                    
                    if (titleController.text.isNotEmpty) {
                      Base.taskController.addTask(
                        Task(
                          title: titleController.text,
                          dueTime: Base.taskController.selectedDateTime.value,
                          imagePath: imagePath,
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
                    // backgroundColor: titleController.text.isNotEmpty
                    //     ? Colors.blueAccent
                    //     : Colors.blueAccent[100], // Button color
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
