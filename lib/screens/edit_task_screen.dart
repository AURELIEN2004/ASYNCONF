import 'package:flutter/material.dart';
import '../models/task.dart';

class EditTaskScreen extends StatefulWidget {

  final Task task;

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {

    titleController =
        TextEditingController(text: widget.task.title);

    descriptionController =
        TextEditingController(text: widget.task.description);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text("Modifier tâche")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Titre",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(

              onPressed: () {

                setState(() {
                  widget.task.title = titleController.text;
                  widget.task.description =
                      descriptionController.text;
                });

                Navigator.pop(context);
              },

              child: const Text("Modifier"),
            ),
          ],
        ),
      ),
    );
  }
}