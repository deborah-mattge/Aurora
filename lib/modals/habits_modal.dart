import 'dart:convert';
import 'dart:ui';
import 'package:aurora/controllers/DailyGoalController.dart';
import 'package:aurora/controllers/HabitController.dart';
import 'package:aurora/controllers/UserController.dart';
import 'package:aurora/models/DailyGoal.dart';
import 'package:aurora/models/Habit.dart';
import 'package:aurora/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitsModal extends ChangeNotifier {
  PeriodLabel selectedPeriod = PeriodLabel.diario; // valor padrão
  TypeLabel selectedType = TypeLabel.booleano; // valor padrão
  Color selectedColor = const Color.fromRGBO(122, 206, 120, 1.0); // valor padrão

  Future<void> firstdialogBuilder(BuildContext context, int habitId) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonUserString = prefs.getString('email');
    User? user;
    if (jsonUserString != null) {
      user = await UserController().getUserByEmail(jsonUserString);
    }

    Habit habit = await HabitController().getOneHabit(habitId, user!.id);
    List<DailyGoal> dailies = await DailyGoalController().getAll(habitId);

    String dailyGoal = " a ";
    for(var daily in dailies){
      if(daily.quantity != null){
        dailyGoal = daily.quantity!.goal.toString();
      }
    }

    final TextEditingController name = TextEditingController(text: habit.name);
    final TextEditingController reference = TextEditingController(text: habit.reference);
    String date = DateFormat('yyyy-MM-dd').format(habit.finalDate);
    final TextEditingController dateController = TextEditingController(text: date);
    final TextEditingController goalController = TextEditingController(text: dailyGoal);

    selectedPeriod = habit.habitCategory;
    selectedType = habit.goalKind;
    selectedColor = habit.color;

    Future<void> selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2101),
      );

      if (pickedDate != null) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        dateController.text = formattedDate;
      }
      notifyListeners();
    }

    Color dropdownBackgroundColor = const Color.fromRGBO(245, 247, 247, 1.0);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(vertical: 170),
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Stack(
              children: [
                Column(
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
                            child: Text("meta: "),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: goalController,
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
                            child: TypeDropdown(
                              habit: habit,
                              onTypeSelected: (TypeLabel type) {
                                selectedType = type;
                              },
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
                            child: PeriodDropdown(
                              habit: habit,
                              onPeriodSelected: (PeriodLabel period) {
                                selectedPeriod = period;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ColorPicker(
                        habit: habit,
                        onColorSelected: (Color color) {
                          selectedColor = color;
                        },
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
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(6),
                                  ),
                                ),
                                backgroundColor:
                                    const Color.fromRGBO(255, 71, 117, 1),
                              ),
                              child: const Text('Cancelar',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                HabitController().updateHabit(
                                  habitId,
                                  name.text,
                                  reference.text,
                                  selectedPeriod,
                                  selectedType,
                                  selectedColor,
                                  dateController.text,
                                );
                                DailyGoalController().updateDailyGoal(
                                  habitId,
                                  goalController.text
                                );
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(6),
                                  ),
                                ),
                                backgroundColor:
                                    const Color.fromRGBO(81, 185, 214, 1),
                              ),
                              child: const Text('Salvar',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PeriodDropdown extends StatefulWidget {
  final Habit habit;
  final ValueChanged<PeriodLabel> onPeriodSelected;

  const PeriodDropdown({required this.habit, required this.onPeriodSelected});

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
              period = selectedPeriod ?? PeriodLabel.noturno;
              widget.onPeriodSelected(period);
              // Update the background color
              dropdownBackgroundColor = _getBackgroundColor(period);
            });
          },
        ),
      ),
    );
  }

  Color _getBackgroundColor(PeriodLabel period) {
    switch (period) {
      case PeriodLabel.noturno:
        return const Color.fromRGBO(81, 185, 214, 1.0);
      case PeriodLabel.matutino:
        return const Color.fromRGBO(255, 71, 117, 1.0);
      case PeriodLabel.vespertino:
        return const Color.fromRGBO(162, 107, 216, 1.0);
      case PeriodLabel.diario:
        return const Color.fromRGBO(122, 206, 120, 1.0);
      default:
        return const Color.fromRGBO(245, 247, 247, 1.0);
    }
  }
}

class TypeDropdown extends StatefulWidget {
  final Habit habit;
  final ValueChanged<TypeLabel> onTypeSelected;

  const TypeDropdown({required this.habit, required this.onTypeSelected});

  @override
  _TypeDropdownState createState() => _TypeDropdownState();
}

class _TypeDropdownState extends State<TypeDropdown> {
  Color dropdownBackgroundColor = const Color.fromRGBO(245, 247, 247, 1.0);
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
              widget.onTypeSelected(period);
            });
          },
        ),
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  final Habit habit;
  final ValueChanged<Color> onColorSelected;

  const ColorPicker({required this.habit, required this.onColorSelected});

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color selectedColor;
  int _selectedIndex = -1;

  final List<Color> _colors = [
    const Color.fromRGBO(122, 206, 120, 1.0),
    const Color.fromRGBO(162, 107, 216, 1.0),
    const Color.fromRGBO(81, 185, 214, 1.0),
    const Color.fromRGBO(255, 71, 117, 1.0),
  ];

  @override
  void initState() {
    super.initState();
    selectedColor = widget.habit.color;
    _selectedIndex = _colors.indexOf(selectedColor);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const SizedBox(
            width: 160,
            child: Text("Cor: "),
          ),
          ...List.generate(_colors.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                    selectedColor = _colors[index];
                    widget.onColorSelected(selectedColor);
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: _colors[index],
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (_selectedIndex == index)
                      const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

