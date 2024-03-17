import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool isDone;

  @HiveField(3)
  int order;

  @HiveField(4)
  int tab;

  Task({
    required this.id,
    required this.title,
    this.isDone = false,
    required this.order,
    required this.tab,
  });

  void setTitle(String newTitle) {
    title = newTitle;
    save();
  }

  void toggleDone() {
    isDone = !isDone;
    save();
  }
}
