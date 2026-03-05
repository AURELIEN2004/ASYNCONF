import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {

  final Function(Task) addTask;

  const AddTaskScreen({super.key, required this.addTask});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

   return Scaffold(
  appBar: AppBar(title: const Text("Ajouter tâche")),

  body: SingleChildScrollView(
    padding: const EdgeInsets.all(20),

    child: Form(
      key: _formKey,

      child: Column(
        children: [

         TextFormField(
  controller: titleController,
  decoration: const InputDecoration(
    labelText: "Titre",
    border: OutlineInputBorder(),
  ),
  validator: (value){
    if(value == null || value.isEmpty){
      return "Entrer un titre";
    }
    return null;
  },
),

          const SizedBox(height: 15),

          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: "Description",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

         SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {

      if (_formKey.currentState!.validate()) {

        final task = Task(
          title: titleController.text,
          description: descriptionController.text,
        );

        widget.addTask(task);

        Navigator.pop(context);
      }

    },
    child: const Text("Ajouter"),
  ),
),
        ],
      ),
    ),
  ),
);
  }

}