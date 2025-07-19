
import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  final _formkey = GlobalKey<FormState>();

  final titlleController = TextEditingController();
  final subtitlleController = TextEditingController();

   @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      key: _formkey,
      child: Form(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'nom de la conference',
                  hintText: "entrer le nom de la conference",
                  border: OutlineInputBorder(),
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return "tu dois completer ce texte";
                    }
                    return null;
                  },
                  controller: titlleController,
              ),
            ),
             Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'subtitle de la conference',
                  hintText: "entrer le intituler de la conference",
                  border: OutlineInputBorder(),
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return "tu dois completer ce texte";
                    }
                    return null;
                  },
                  controller: subtitlleController,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton( 
                
                onPressed: () {
                  if(_formkey.currentState!.validate()){
                    // ignore: unused_local_variable
                    final title = titlleController.text;
                    // ignore: unused_local_variable
                    final subtitle = subtitlleController.text;
                    ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text("envoi en cours"))
                    );
                    
                  }
                },
               child: Text("Envoyer")
               ),
            )
          ],
        ),
      ),
    );
  }
}