import 'package:asynconf/pages/add_event_page.dart';
import 'package:asynconf/pages/event_page.dart';
import 'package:asynconf/pages/home_page.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
int _currentIndex = 0;

setCurrentindex(int index){
  setState(() {
    _currentIndex = index;
  }
  );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: [
          Text( ' Accueil', style: TextStyle(color: Colors.white)),
          Text( ' liste des conferences', style: TextStyle(color: Colors.white)  ),
          Text( 'Formulaire d ajout', style: TextStyle(color: Colors.white),  ),
          ][_currentIndex]
            ),

             body: [
              HomePage(),
              EventPage(),
              AddEventPage()
             ][_currentIndex ]
,
             bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setCurrentindex(index);
              },
              selectedItemColor: Colors.blue,
              unselectedItemColor: const Color.fromARGB(255, 59, 58, 58),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event),
                  label: 'Events',
                ),
                 BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Ajout',
                ),
              ]
              
        ),
      )
    );

  }
}

