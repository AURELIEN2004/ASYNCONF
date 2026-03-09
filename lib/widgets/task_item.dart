import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskItem extends StatelessWidget {

  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onToggle;
  final VoidCallback onEdit;

  const TaskItem({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onToggle,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(

        leading: Checkbox(
          value: task.isDone,
          onChanged: (value) {
            onToggle();
          },
        ),

        title: Text(
          task.title,
          style: TextStyle(
            decoration:
                task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description),
           Text(
  task.date != null
      ? "${task.date.day}/${task.date.month}/${task.date.year}"
      : "Pas de date",
  style: const TextStyle(color: Colors.grey),
),
          ],
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),

            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}