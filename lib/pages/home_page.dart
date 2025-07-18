import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            SvgPicture.asset(
            "assets/images/mini.svg",
             color: Colors.blue,
             ),
            
            
            const Text(
              'Asynconf 2024',
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
            ),
            const Text(
              'salon virtuel de l informatique du 21 au 31 decembre 2024',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
           
            // A counter widget can be added here
          ],
        ),
      );
  }
}