import 'package:hive/hive.dart';

part 'task_model.g.dart'; // Required for code generation

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime dueTime;

  @HiveField(2)
  String? imagePath;

  @HiveField(3)
  bool isDone;

  Task(
      {required this.title,
      required this.dueTime,
      this.imagePath,
      this.isDone = false});
}
