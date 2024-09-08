import 'package:hive/hive.dart';

part 'task_model.g.dart'; // Required for code generation

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime dueTime;

  @HiveField(3)
  String? imagePath;

  @HiveField(4)
  bool isDone;

  Task(
      {required this.id,
      required this.title,
      required this.dueTime,
      this.imagePath,
      this.isDone = false});
}
