// import 'package:flutter/material.dart';
// import '../models/task.dart';
// import '../widgets/task_item.dart';
// import 'add_task_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {

//   List<Task> tasks = [];

//   void addTask(Task task) {
//     setState(() {
//       tasks.add(task);
//     });
//   }

//   void deleteTask(int index) {
//     setState(() {
//       tasks.removeAt(index);
//     });
//   }

//   void toggleTask(int index) {
//     setState(() {
//       tasks[index].isDone = !tasks[index].isDone;
//     });
//   }

//   void editTask(int index, Task updatedTask) {
//     setState(() {
//       tasks[index] = updatedTask;
//     });
//   }

//   void openAddTask() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddTaskScreen(addTask: addTask),
//       ),
//     );
//   }

//   void openEditTask(int index) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddTaskScreen(
//           addTask: (task) {
//             editTask(index, task);
//           },
//           existingTask: tasks[index],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Todo App"),
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: openAddTask,
//         child: const Icon(Icons.add),
//       ),

//       body: tasks.isEmpty
//           ? const Center(
//               child: Text(
//                 "Aucune tâche",
//                 style: TextStyle(fontSize: 18),
//               ),
//             )
//           : ListView.builder(
//               itemCount: tasks.length,
//               itemBuilder: (context, index) {
//                 return TaskItem(
//                   task: tasks[index],
//                   onDelete: () => deleteTask(index),
//                   onToggle: () => toggleTask(index),
//                   onEdit: () => openEditTask(index),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../models/task.dart';
import '../widgets/task_item.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = [];
  String _filter = 'all'; // all | done | pending
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initNotifications();
    _loadTasks();
  }

  // --- 1. INITIALISATION DES NOTIFICATIONS ---
  Future<void> _initNotifications() async {
    tz.initializeTimeZones();
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _notificationsPlugin.initialize(
      const InitializationSettings(android: androidSettings),
    );
  }

  Future<void> _scheduleNotification(Task task, int id) async {
    if (task.dueDate == null || task.isDone) return;
    
    // On ne programme que si la date est dans le futur
    if (task.dueDate!.isBefore(DateTime.now())) return;

    await _notificationsPlugin.zonedSchedule(
      id,
      'Rappel de tâche',
      'Il est temps de : ${task.title}',
      tz.TZDateTime.from(task.dueDate!, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_reminders', 'Rappels de tâches',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // --- 2. GESTION DU STOCKAGE (No-DB) ---
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(_tasks.map((t) => {
      'title': t.title,
      'description': t.description,
      'dueDate': t.dueDate?.toIso8601String(),
      'isDone': t.isDone,
    }).toList());
    await prefs.setString('tasks_storage', encodedData);
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString('tasks_storage');
    if (savedData != null) {
      final List<dynamic> decodedData = jsonDecode(savedData);
      setState(() {
        _tasks = decodedData.map((item) => Task(
          title: item['title'],
          description: item['description'],
          dueDate: item['dueDate'] != null ? DateTime.parse(item['dueDate']) : null,
          isDone: item['isDone'],
        )).toList();
      });
    }
  }

  // --- 3. LOGIQUE CRUD AMÉLIORÉE ---
  void _addTask(Task task) {
    setState(() {
      _tasks.add(task);
      _saveTasks();
      _scheduleNotification(task, _tasks.length);
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _notificationsPlugin.cancel(index);
      _tasks.removeAt(index);
      _saveTasks();
    });
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
      if (_tasks[index].isDone) {
        _notificationsPlugin.cancel(index); // Annule le rappel si fait
      }
      _saveTasks();
    });
  }

  // --- 4. TRI ET FILTRAGE ---
  List<Task> get _filteredTasks {
    List<Task> list = _tasks;
    if (_filter == 'done') list = list.where((t) => t.isDone).toList();
    if (_filter == 'pending') list = list.where((t) => !t.isDone).toList();
    return list;
  }

  void _sortTasks(String criteria) {
    setState(() {
      if (criteria == 'date') {
        _tasks.sort((a, b) => (a.dueDate ?? DateTime(2100)).compareTo(b.dueDate ?? DateTime(2100)));
      } else if (criteria == 'alpha') {
        _tasks.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
      }
      _saveTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Tâches"),
        actions: [
          // Menu de Filtrage
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (val) => setState(() => _filter = val),
            itemBuilder: (ctx) => [
              const PopupMenuItem(value: 'all', child: Text("Toutes")),
              const PopupMenuItem(value: 'pending', child: Text("En cours")),
              const PopupMenuItem(value: 'done', child: Text("Terminées")),
            ],
          ),
          // Menu de Tri
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: _sortTasks,
            itemBuilder: (ctx) => [
              const PopupMenuItem(value: 'date', child: Text("Trier par date")),
              const PopupMenuItem(value: 'alpha', child: Text("Trier par titre")),
            ],
          ),
        ],
      ),
      body: _filteredTasks.isEmpty
          ? const Center(child: Text("Aucune tâche trouvée"))
          : ListView.builder(
              itemCount: _filteredTasks.length,
              itemBuilder: (ctx, index) {
                final task = _filteredTasks[index];
                return TaskItem(
                  task: task,
                  onDelete: () => _deleteTask(index),
                  onToggle: () => _toggleTask(index),
                  onEdit: () {
                    // Logique d'édition...
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => AddTaskScreen(addTask: _addTask)),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}