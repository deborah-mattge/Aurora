import 'dart:convert';

import 'package:aurora/controllers/UserController.dart';
import 'package:aurora/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateUserModal {
  Future<void> firstdialogBuilder(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonUserString = prefs.getString('email');
    User? user;
    if (jsonUserString != null) {
      user = await UserController().getUserByEmail(jsonUserString);
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Perfil',
            style: TextStyle(color: Colors.pink),
          ),
          insetPadding: EdgeInsets.symmetric(vertical: 320),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    const Icon(Icons.person, color: Colors.blue),
                    Text(
                      user?.name ?? 'Email não encontrado',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Row(
                  children: [
                    const Icon(Icons.email, color: Colors.blue),
                    Text(
                      user?.email ?? 'Nome não encontrado',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    )
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Icon(Icons.edit_square, color: Colors.pink),
                onPressed: () => seconddialogBuilder(context)
                // Navigator.of(context).pop();
                ),
          ],
        );
      },
    );
  }

  Future<void> seconddialogBuilder(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonUserString = prefs.getString('email');
    User? user;
    if (jsonUserString != null) {
      user = await UserController().getUserByEmail(jsonUserString);
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Perfil',
            style: TextStyle(color: Colors.pink),
          ),
          insetPadding: EdgeInsets.symmetric(vertical: 300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    const Icon(Icons.person, color: Colors.blue),
                    Text(
                      user?.name ?? 'Email não encontrado',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Row(
                  children: [
                    const Icon(Icons.email, color: Colors.blue),
                    Text(
                      user?.email ?? 'Nome não encontrado',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Row(
                  children: [
                    const Icon(Icons.lock, color: Colors.blue),
                    Text(
                      user?.password ?? 'Nome não encontrado',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
                backgroundColor: Color.fromRGBO(221, 79, 240, 1),
              ),
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
                backgroundColor: Color.fromRGBO(81, 185, 214, 1.0),
              ),
              child: const Text("Salvar"),
              onPressed: () {
                UserController().updateUser(user!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
