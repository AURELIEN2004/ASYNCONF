import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskPage extends StatefulWidget {

  final Function(Task) addTask;

  const AddTaskPage({
    super.key,
    required this.addTask,
  });

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(20),

      child: Form(
        key: _formKey,

        child: Column(
          children: [

            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Titre de la tâche",
                border: OutlineInputBorder(),
              ),

              validator: (value){
                if(value == null || value.isEmpty){
                  return "Entrer un titre";
                }
                return null;
              },
            ),

            const SizedBox(height: 10),

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
              height: 50,

              child: ElevatedButton(

                onPressed: () {

                  if(_formKey.currentState!.validate()){

                    final task = Task(
                      title: titleController.text,
                      description: descriptionController.text,
                    );

                    widget.addTask(task);

                    titleController.clear();
                    descriptionController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Tâche ajoutée"))
                    );
                  }
                },

                child: const Text("Ajouter"),
              ),
            )

          ],
        ),
      ),
    );
  }
}