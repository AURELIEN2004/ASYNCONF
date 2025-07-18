import 'package:flutter/material.dart';


class EventPage extends StatefulWidget {
  const EventPage
({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

   final events = [
    {
      'title': 'eren yeager',
      'time': '17h30 a 18h',
      'subtitle': 'git blame --no-offense ?',
      'image': 'assets/images/img1.jpg',
    },
    {
      'title': 'mikasa ackerman',
      'time': '18h00 a 18h30',
      'subtitle': 'je suis AMOUREUSE D EREN !',
      'image': 'assets/images/img2.jpg',
    },
    {
      'title': 'armin arlert',
      'time': '18h30 a 19h00',
      'subtitle': 'la connaissance est la clé !',
      'image': 'assets/images/img3.jpg',
    },
    {
      'title': 'levi ackerman',
      'time': '19h00 a 19h30',
      'subtitle': 'je suis le meilleur !',
      'image': 'assets/images/img1.jpg',
    },
   ];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
           itemCount: events.length,
           itemBuilder: (context, index) {
             final event = events[index];
             return Card(
               margin: const EdgeInsets.all(8.0),
               child: ListTile(
                 leading: CircleAvatar(
                   backgroundImage: AssetImage(event['image']!),
                 ),
                 title: Text(event['title']!),
                 subtitle: Text('${event['time']} - ${event['subtitle']}'),
               ),
             );
           },
        
        ),
      );
      
  }
}
