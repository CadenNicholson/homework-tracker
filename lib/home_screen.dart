import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  
  @override
  Widget build(BuildContext context){
    return Center(
    child: Column(
        mainAxisSize:MainAxisSize.min,
        children: [
      Text( // TEXT ON SCREEN
          'Welcome to Homework Tracker!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      TextButton( // TEXT BUTTON
    child: Text(
        "Get Started!",
        style: TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
    ),
    onPressed: () {},
),
      TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Homework Tracker!'),
          content: const Text('Made by Caden Nicholson!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('App Info'),
    )
  
        ],
      ),
    );

  }



}
