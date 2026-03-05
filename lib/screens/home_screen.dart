import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_item.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Task> tasks = [];

  void addTask(Task task) {

    setState(() {
      tasks.add(task);
    });
  }

  void deleteTask(int index) {

    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleTask(int index, bool? value) {

    setState(() {
      tasks[index].isDone = value!;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Todo App"),
      ),

      body: tasks.isEmpty
          ? const Center(child: Text("Aucune tâche"))
          : ListView.builder(

              itemCount: tasks.length,

              itemBuilder: (context, index) {

                final task = tasks[index];

                return TaskItem(

                  task: task,

                  onDelete: () => deleteTask(index),

                  onToggle: (value) =>
                      toggleTask(index, value),

                  onEdit: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            EditTaskScreen(task: task),
                      ),
                    ).then((_) => setState(() {}));
                  },
                );
              },
            ),

      floatingActionButton: FloatingActionButton(

        child: const Icon(Icons.add),

        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AddTaskScreen(addTask: addTask),
            ),
          );
        },
      ),
    );
  }
}