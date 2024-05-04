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

    Habit habit = await HabitController().getOneHabit(2, user!.id);
    debugPrint(habit.name);

    final TextEditingController name = TextEditingController(text: habit.name);
    final TextEditingController date = TextEditingController(text: habit.name);
    const List<String> list = <String>[
      'noturno  ',
      'matutino  ',
      'vespertino',
      'diário   '
    ];
    const List<String> list2 = <String>['a', 'b', 'c', 'd'];

    Future<void> selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2101),
      );

      if (pickedDate != null && pickedDate != DateTime.now()) {
        date.text = pickedDate.toString();
      }
    }

    return showDialog<void>(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(vertical: 200),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(245, 247, 247, 1.0),
                              borderRadius: BorderRadius.circular(30),
                            ),
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
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(245, 247, 247, 1.0),
                              borderRadius: BorderRadius.circular(30),
                            ),
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
                            child: DropdownButtonHideUnderline(
                              child: DropdownMenu<PeriodLabel>(
                                initialSelection: PeriodLabel.noturno,
                                // controller: colorController
                                requestFocusOnTap: true,
                                inputDecorationTheme:
                                    const InputDecorationTheme(
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
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 120,
                          child: Text("cor: "),
                        ),
                        const SizedBox(width: 150),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: PeriodLabel.noturno.color,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                icon: const SizedBox.shrink(),
                                items: list2
                                    .map((value) => DropdownMenuItem(
                                          child: Text(value),
                                          value: value,
                                        ))
                                    .toList(),
                                // ignore: avoid_types_as_parameter_names
                                onChanged: (String) {},
                                isExpanded: false,
                                value: list2.first,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 150,
                          child: Text("Data de término: "),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: date,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor:
                                  const Color.fromRGBO(245, 247, 247, 1.0),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () => selectDate(context),
                              ),
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