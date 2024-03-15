class Task {
  int id;
  String title;
  bool isDone;

  Task({required this.id, required this.title, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}
