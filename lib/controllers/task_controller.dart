import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/services/notification_service.dart';
import '../model/task_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs; // Observable list of tasks
  late Box<Task> taskBox;
  final NotificationService notificationService = NotificationService();

  @override
  void onInit() {
    super.onInit();
    initHive(); // Initialize Hive when the controller is initialized
  }

  Future<void> initHive() async {
    taskBox = await Hive.openBox<Task>('taskBox');
    tasks.assignAll(taskBox.values.toList());
  }

  void addTask(Task task) async {
    taskBox.add(task);
    tasks.add(task);
    scheduleTaskReminder(task);
  }

  void updateTask(Task task) {
    task.save(); // HiveObject provides save() to update local data
    tasks.refresh();
  }

  void deleteTask(Task task) {
    task.delete(); // HiveObject provides delete() to remove the task
    tasks.remove(task);
  }

  void toggleTaskCompletion(Task task) {
    task.isDone = !task.isDone;
    task.save();
    tasks.refresh();
  }

  // Function to schedule a reminder
  void scheduleTaskReminder(Task task) {
    final DateTime now = DateTime.now();
    final Duration difference = task.dueTime.difference(now);

    if (difference.isNegative) {
      // Task due time has already passed
      return;
    }

    Future.delayed(difference, () {
      _sendNotification(task);
    });
  }

  // Send notification
  Future<void> _sendNotification(Task task) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'reminder_channel_id', 'reminder_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      sound:
          RawResourceAndroidNotificationSound('notification'), // Custom sound
      playSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Task Reminder',
      'It\'s time for your task: ${task.title}',
      platformChannelSpecifics,
    );
  }

  // Reactive DateTime variable
  var selectedDateTime = DateTime.now().obs;

  // Function to pick date and time
  Future<void> selectDateTime(BuildContext context) async {
    // Pick a date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Pick a time if a date was selected
      TimeOfDay? pickedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime.value),
      );

      if (pickedTime != null) {
        // Combine picked date and time into a DateTime object
        selectedDateTime.value = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
  }
}
