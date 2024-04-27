import 'dart:convert';
import 'dart:ui';

import 'package:aurora/controllers/HabitController.dart';
import 'package:aurora/controllers/UserController.dart';
import 'package:aurora/models/Habit.dart';
import 'package:aurora/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitsModal {
  Future<void> firstdialogBuilder(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonUserString = prefs.getString('email');
    User? user;
    if (jsonUserString != null) {
      user = await UserController().getUserByEmail(jsonUserString);
    }

    Habit habit = await HabitController().getOneHabit(1, user!.id);
    debugPrint(habit.name);

    final TextEditingController name = TextEditingController(text: habit.name);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(vertical: 200),
          backgroundColor: Colors.white,
          content: Column(
            children: [
              Row(
                children: [
                  Text('Nome'),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        filled: true,
                        fillColor: Colors.white, // Fundo branco
                        contentPadding: EdgeInsets.all(4.2),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('tipo da unidade'),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        filled: true,
                        fillColor: Colors.white, // Fundo branco
                        contentPadding: EdgeInsets.all(4.2),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('período'),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        filled: true,
                        fillColor: Colors.white, // Fundo branco
                        contentPadding: EdgeInsets.all(4.2),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('cor'),
                  SizedBox(width: 10),
                  Expanded(
                            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
                color: Colors.red, style: BorderStyle.solid, width: 0.80),
          ),
          // child: DropdownButton(
          //   items: _dropdownValues
          //       .map((value) => DropdownMenuItem(
          //             child: Text(value),
          //             value: value,
          //           ))
          //       .toList(),
            // onChanged: (String value) {},
            // isExpanded: false,
            // value: _dropdownValues.first,
          ),
        ),

                  // ),
                ],
              ),
              Row(
                children: [
                  Text('Data de término'),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.6, // Adjust the width as needed
                      child: TextField(
                        controller: name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        backgroundColor: const Color.fromRGBO(255, 71, 117, 1)),
                    child: const Text('Cancelar',
                        style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        backgroundColor: const Color.fromRGBO(81, 185, 214, 1)),
                    child: const Text('Salvar',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
