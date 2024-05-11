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

    final TextEditingController name = TextEditingController(text: habit.name);
    final TextEditingController reference =
        TextEditingController(text: habit.reference);
    String date = "${habit.finalDate.day}/${habit.finalDate.month}/${habit.finalDate.year}";
    final TextEditingController dateController =
        TextEditingController(text: date);
    const List<String> list = <String>[
      'noturno  ',
      'matutino  ',
      'vespertino',
      'diário   '
    ];

    const List<String> listTypes = <String>[
      'Booleano  ',
      'Quantidade',
      'Tempo'
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
        reference.text = pickedDate.toString();
      }
    }

    Color dropdownBackgroundColor = Color.fromARGB(255, 255, 255, 255);

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
                          child: TextField(
                            controller: name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: dropdownBackgroundColor,
                              contentPadding: const EdgeInsets.all(12),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
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
                          width: 150,
                          child: Text("nome da unidade: "),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: reference,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: dropdownBackgroundColor,
                              contentPadding: const EdgeInsets.all(12),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
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
                          width: 150,
                          child: Text("tipo da unidade: "),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TypeDropdown(habit: habit),
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
                          child: PeriodDropdown(habit: habit),
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
                              color: habit.color,
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
                            controller: dateController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: dropdownBackgroundColor,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
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

class PeriodDropdown extends StatefulWidget {
  final Habit habit;

  const PeriodDropdown({required this.habit});

  @override
  _PeriodDropdownState createState() => _PeriodDropdownState();
}

class _PeriodDropdownState extends State<PeriodDropdown> {
  Color dropdownBackgroundColor = Colors.blue;
  late PeriodLabel period;

  @override
  void initState() {
    super.initState();
    period = widget.habit.habitCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: dropdownBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: period,
          items: PeriodLabel.values
              .map((label) => DropdownMenuItem(
                    child: Text(label.name),
                    value: label,
                  ))
              .toList(),
          onChanged: (PeriodLabel? selectedPeriod) {
            setState(() {
              if (selectedPeriod == PeriodLabel.noturno) {
                dropdownBackgroundColor = const Color.fromRGBO(81, 185, 214, 1.0);
                period = PeriodLabel.noturno;
              } else if (selectedPeriod == PeriodLabel.matutino) {
                dropdownBackgroundColor = const Color.fromRGBO(255, 71, 117, 1.0);
                period = PeriodLabel.matutino;
              } else if (selectedPeriod == PeriodLabel.vespertino) {
                dropdownBackgroundColor = const Color.fromRGBO(162, 107, 216, 1.0);
                period = PeriodLabel.vespertino;
              } else if (selectedPeriod == PeriodLabel.diario) {
                dropdownBackgroundColor = const Color.fromRGBO(122, 206, 120, 1.0);
                period = PeriodLabel.diario;
              }
            });
          },
        ),
      ),
    );
  }
}

class TypeDropdown extends StatefulWidget {
  final Habit habit;

  const TypeDropdown({required this.habit});

  @override
  _TypeDropdownState createState() => _TypeDropdownState();
}

class _TypeDropdownState extends State<TypeDropdown> {
  Color dropdownBackgroundColor = Colors.white;
  late TypeLabel period;

  @override
  void initState() {
    super.initState();
    period = widget.habit.goalKind;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: dropdownBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: period,
          items: TypeLabel.values
              .map((label) => DropdownMenuItem(
                    child: Text(label.name),
                    value: label,
                  ))
              .toList(),
          onChanged: (TypeLabel? selectedType) {
            setState(() {
              period = selectedType ?? TypeLabel.booleano;
            });
          },
        ),
      ),
    );
  }
}
