import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/services/notification_service.dart';
import '../model/task_model.dart';

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
}
