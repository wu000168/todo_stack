import 'package:flutter/cupertino.dart';

class Task {
  String title;
  String? description;
  Task(this.title, [this.description]);
}

class TaskList {
  final String title;
  List<Task> tasks;
  TaskList(this.title, this.tasks);
}
