import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskPage extends StatefulWidget {
  final List<Task> tasks;
  final Function(int) deleteTask;

  const TaskPage({
    super.key,
    required this.tasks,
    required this.deleteTask,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {

        final task = widget.tasks[index];

        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: const Icon(Icons.task),
            title: Text(task.title),
            subtitle: Text(task.description),

            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                widget.deleteTask(index);
              },
            ),
          ),
        );
      },
    );
  }
}