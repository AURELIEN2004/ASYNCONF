// import 'package:asynconf/pages/add_event_page.dart';
// import 'package:asynconf/pages/event_page.dart';
// import 'package:asynconf/pages/home_page.dart';
// import 'package:flutter/material.dart';
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // This widget is the root of your application.
// int _currentIndex = 0;

// setCurrentindex(int index){
//   setState(() {
//     _currentIndex = index;
//   }
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.blue,
//           title: [
//           Text( ' Accueil', style: TextStyle(color: Colors.white)),
//           Text( ' liste des conferences', style: TextStyle(color: Colors.white)  ),
//           Text( 'Formulaire d ajout', style: TextStyle(color: const Color.fromARGB(255, 165, 22, 22)),  ),
//           ][_currentIndex]
//             ),

//              body: [
//               HomePage(),
//               EventPage(),
//               AddEventPage(),
//              ][_currentIndex ]
// ,
//              bottomNavigationBar: BottomNavigationBar(
//               currentIndex: _currentIndex,
//               onTap: (index) {
//                 setCurrentindex(index);
//               },
//               selectedItemColor: Colors.blue,
//               unselectedItemColor: const Color.fromARGB(255, 59, 58, 58),
//               items: const [
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.event),
//                   label: 'Events',
//                 ),
//                  BottomNavigationBarItem(
//                   icon: Icon(Icons.add),
//                   label: 'Ajout',
//                 ),
//               ]
              
//         ),
//       )
//     );

//   }
// }

import 'package:flutter/material.dart';
import 'models/task.dart';
import 'pages/task_page.dart';
import 'pages/add_task_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _currentIndex = 0;

  final List<Task> tasks = [];

  void addTask(Task task){
    setState(() {
      tasks.add(task);
    });
  }

  void deleteTask(int index){
    setState(() {
      tasks.removeAt(index);
    });
  }

  void setCurrentIndex(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(

        appBar: AppBar(
          title: const Text("Application de Tâches"),
        ),

        body: [

          TaskPage(
            tasks: tasks,
            deleteTask: deleteTask,
          ),

          AddTaskPage(
            addTask: addTask,
          ),

        ][_currentIndex],

        bottomNavigationBar: BottomNavigationBar(

          currentIndex: _currentIndex,

          onTap: setCurrentIndex,

          items: const [

            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "Tâches",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Ajouter",
            ),

          ],
        ),
      ),
    );
  }
}