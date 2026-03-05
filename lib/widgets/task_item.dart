import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskItem extends StatelessWidget {

  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final Function(bool?) onToggle;

  const TaskItem({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onEdit,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),

      child: ListTile(

        leading: Checkbox(
          value: task.isDone,
          onChanged: onToggle,
        ),

        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration:
                task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),

        subtitle: Text(task.description),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),

            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}