import 'package:flutter/material.dart';
import 'package:aurora/controllers/UserController.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Post Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Post Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}
