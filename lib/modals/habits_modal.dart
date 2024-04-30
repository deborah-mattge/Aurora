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
    const List<String> list = <String>[
      'noturno  ',
      'matutino  ',
      'vespertino',
      'diário   '
    ];

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(vertical: 200),
            backgroundColor: Colors.white,
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 150,
                          child: Text("nome: "),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Color.fromRGBO(245, 247, 247, 1.0),
                              contentPadding: EdgeInsets.all(4.2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 150, // Defina o tamanho fixo aqui
                          child: Text("nome da unidade: "),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Color.fromRGBO(245, 247, 247, 1.0),
                              contentPadding: EdgeInsets.all(4.2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 150, // Defina o tamanho fixo aqui
                          child: Text("tipo da unidade: "),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Color.fromRGBO(245, 247, 247, 1.0),
                              contentPadding: EdgeInsets.all(4.2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 150,
                          child: Text("Período: "),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: PeriodLabel.noturno.color,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownMenu<PeriodLabel>(
                              initialSelection: PeriodLabel.noturno,
                              // controller: colorController
                              requestFocusOnTap: true,
                              inputDecorationTheme: const InputDecorationTheme(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 5.0),
                              ),
                              onSelected: (PeriodLabel? color) {
                                // setState(() {
                                //   selectedColor = color;
                                // });
                              },
                              dropdownMenuEntries: PeriodLabel.values
                                  .map<DropdownMenuEntry<PeriodLabel>>(
                                      (PeriodLabel color) {
                                return DropdownMenuEntry<PeriodLabel>(
                                  value: color,
                                  label: color.label,
                                  style: MenuItemButton.styleFrom(
                                    foregroundColor: color.color,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 270,
                          child: Text("cor: "),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(190, 185, 254, 1.0),
                              contentPadding: EdgeInsets.all(4.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 150, // Defina o tamanho fixo aqui
                          child: Text("data de término: "),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.calendar_month),
                              suffixIconColor: Color.fromRGBO(255, 71, 117, 1.0),  
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Color.fromRGBO(245, 247, 247, 1.0),
                              contentPadding: EdgeInsets.all(4.2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            backgroundColor:
                                const Color.fromRGBO(255, 71, 117, 1)),
                        child: const Text('Cancelar',
                            style: TextStyle(color: Colors.white)),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            backgroundColor:
                                const Color.fromRGBO(81, 185, 214, 1)),
                        child: const Text('Salvar',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

enum PeriodLabel {
  noturno('noturno', Color.fromRGBO(81, 185, 214, 1.0)),
  matutino('matutino', Color.fromRGBO(255, 71, 117, 1.0)),
  vespertino('vespertino', Color.fromRGBO(122, 206, 120, 1.0)),
  diario('diario', Color.fromRGBO(162, 107, 216, 1.0));

  const PeriodLabel(this.label, this.color);
  final String label;
  final Color color;
}
