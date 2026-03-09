import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {

  final Function(Task) addTask;
  final Task? existingTask;

  const AddTaskScreen({
    super.key,
    required this.addTask,
    this.existingTask,
  });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.existingTask != null) {
      titleController.text = widget.existingTask!.title;
      descriptionController.text = widget.existingTask!.description;
      selectedDate = widget.existingTask!.date;
    }
  }

  void submitTask() {

    if (!_formKey.currentState!.validate()) return;

    Task task = Task(
      title: titleController.text,
      description: descriptionController.text,
      dueDate: selectedDate,
    );

    widget.addTask(task);

    Navigator.pop(context);
  }

  // void pickDate() async {

  //   DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(2100),
  //   );

  //   if (picked != null) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }
  void pickDate() async {
  // 1. Choisir le jour
  DateTime? date = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );

  if (date != null) {
    // 2. Choisir l'heure
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        selectedDate = DateTime(
          date.year, date.month, date.day, 
          time.hour, time.minute
        );
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {

    bool isEdit = widget.existingTask != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Modifier tâche" : "Ajouter tâche"),
      ),

      body: Padding(
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
                validator: (value) =>
                    value!.isEmpty ? "Entrer un titre" : null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [

                  Expanded(
                    child: Text(
                      "Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                    ),
                  ),

                  TextButton(
                    onPressed: pickDate,
                    child: const Text("Choisir"),
                  )
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitTask,
                  child: Text(isEdit ? "Modifier" : "Ajouter"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}