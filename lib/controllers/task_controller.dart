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

  void addTask(Task task) {
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
      sound: RawResourceAndroidNotificationSound('notification'), // Custom sound
      playSound: true,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics,);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Task Reminder',
      'It\'s time for your task: ${task.title}',
      platformChannelSpecifics,
    );
  }
}
