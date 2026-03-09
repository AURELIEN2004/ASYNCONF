class Task {

  String title;
  String description;
  DateTime? dueDate;
  bool isDone;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    this.isDone = false,
  });

  get date => dueDate;
}