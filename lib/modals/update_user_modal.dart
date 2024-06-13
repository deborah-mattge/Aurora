import 'dart:convert';

import 'package:aurora/controllers/UserController.dart';
import 'package:aurora/models/UserModel.dart';
import 'package:aurora/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aurora/main.dart' as main;

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
            style: TextStyle(
                color: Color.fromRGBO(255, 71, 117, 1),
                fontFamily: 'Montserrat'),
          ),
          insetPadding: const EdgeInsets.symmetric(vertical: 320),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    const Icon(Icons.person,
                        color: Color.fromRGBO(81, 185, 214, 1)),
                    Text(
                      user?.name ?? 'Email não encontrado',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 74, 73, 73),
                          fontFamily: 'Montserrat'),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Row(
                  children: [
                    const Icon(Icons.email,
                        color: Color.fromRGBO(81, 185, 214, 1)),
                    Text(
                      user?.email ?? 'Nome não encontrado',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 74, 73, 73),
                          fontFamily: 'Montserrat'),
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
                child: const Icon(Icons.logout,
                    color: Color.fromRGBO(255, 71, 117, 1)),
                onPressed: () => logout(context)
                // Navigator.of(context).pop();
                ),
            TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Icon(Icons.edit_square,
                    color: Color.fromRGBO(255, 71, 117, 1)),
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
    final TextEditingController nameController =
        TextEditingController(text: user?.name ?? 'Nome não encontrado');
    final TextEditingController emailController =
        TextEditingController(text: user?.email ?? 'Email não encontrado');
    final TextEditingController passwordController =
        TextEditingController(text: user?.password ?? 'Senha não encontrada');
    final TextEditingController confirmPasswordController =
        TextEditingController(text: user?.password ?? 'Senha não encontrada');

    return showDialog<void>(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Perfil',
            style: TextStyle(
                color: Color.fromRGBO(255, 71, 117, 1),
                fontFamily: 'Montserrat'),
          ),
          insetPadding: const EdgeInsets.symmetric(vertical: 260),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.person,
                      color: Color.fromRGBO(81, 185, 214, 1)),
                  Expanded(
                    child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: nameController),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.email,
                      color: Color.fromRGBO(81, 185, 214, 1)),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: emailController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.lock,
                      color: Color.fromRGBO(81, 185, 214, 1)),
                  Expanded(
                    child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: passwordController),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.lock,
                      color: Color.fromRGBO(81, 185, 214, 1)),
                  Expanded(
                    child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: confirmPasswordController),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      backgroundColor: const Color.fromRGBO(255, 71, 117, 1),
                    ),
                    child: const Text("Cancelar",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      backgroundColor: const Color.fromRGBO(81, 185, 214, 1),
                    ),
                    child: const Text("Salvar",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (confirmPasswordController.text ==
                          passwordController.text) {
                        UserController().updateUser(nameController.text,
                            emailController.text, passwordController.text);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

Future<void> logout(BuildContext context) async {
  await clearUserSession();
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => Login()),
  );
}

  Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }
