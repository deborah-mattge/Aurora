import 'dart:convert';

import 'package:aurora/controllers/UserController.dart';
import 'package:aurora/modals/update_user_modal.dart';
import 'package:aurora/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Post Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('showDialog Sample')),
      body: Center(
        child: OutlinedButton(
          onPressed: () => UpdateUserModal().firstdialogBuilder(context),
          child: const Text('Open Dialog'),
        ),
      ),
    );
  }

  @override
  void dispose() {}
}

