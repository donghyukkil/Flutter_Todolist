import 'package:get/get.dart';

class Task {
  final int id;
  final RxString title;
  final RxBool isDone;

  Task({required this.id, required String title, bool isDone = false})
      : title = title.obs,
        isDone = RxBool(isDone);

  Task copyWith({
    String? title,
    bool? isDone,
  }) {
    return Task(
      id: id,
      title: title ?? this.title.value,
      isDone: isDone ?? this.isDone.value,
    );
  }

  void setTitle(String newTitle) {
    title.value = newTitle;
  }

  void toggleDone() {
    isDone.toggle();
  }
}
