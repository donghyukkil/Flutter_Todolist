import 'package:get/get.dart';

class Task {
  int id;
  RxString title;
  RxBool isDone;

  Task({required this.id, required String title, bool isDone = false})
      : title = title.obs,
        isDone = RxBool(isDone);

  void setTitle(String newTitle) {
    title.value = newTitle;
  }

  void toggleDone() {
    isDone.toggle();
  }
}
