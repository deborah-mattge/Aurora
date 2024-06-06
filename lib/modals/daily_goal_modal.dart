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

class DailyGoalModal extends StatefulWidget {
  final int dailyId;
  final int habitId;
  const DailyGoalModal({Key? key, required this.dailyId, required this.habitId})
      : super(key: key);
  @override
  _DailyGoalModalState createState() => _DailyGoalModalState();
}

class _DailyGoalModalState extends State<DailyGoalModal> {
  int? counter;
  String? habitName;
  String? goalVsCurrent2;
  int? goal;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonUserString = prefs.getString('email');
    User? user;
    if (jsonUserString != null) {
      user = await UserController().getUserByEmail(jsonUserString);
    }
    Habit habit = await HabitController().getOneHabit(widget.habitId, user!.id);
    habitName = habit.name;
    DailyGoal daily = await DailyGoalController().getOneDaily(widget.dailyId);
    if (daily.quantity != null) {
      counter = daily.quantity!.currentStatus;
      goal = daily.quantity!.goal;
      goalVsCurrent2 =
          "${daily.quantity!.currentStatus}/${daily.quantity!.goal}${habit.reference}";
    }
    setState(() {});
  }

  void _incrementCounter() {
    setState(() {
      if (counter != null) {
        counter = counter! + 1;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (counter != null && counter! > 0) {
        counter = counter! - 1;
      }
    });
  }

  void _saveCounter() {
    if (counter != null) {
      DailyGoalController().updateQuantity(widget.dailyId, counter!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 100),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (habitName != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        habitName!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    child: ElevatedButton(
                      onPressed: _decrementCounter,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(255, 71, 117, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Icon(Icons.remove, color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 48, // Ajuste a altura para corresponder aos botões
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      counter != null && goal != null ? "$counter / $goal" : '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    child: ElevatedButton(
                      onPressed: _incrementCounter,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(81, 185, 214, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            if (goalVsCurrent2 != null) ...[
              Text(
                goalVsCurrent2!,
                style: const TextStyle(fontSize: 16),
              ),
            ],
            const SizedBox(height: 16),
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
                        backgroundColor: const Color.fromRGBO(255, 71, 117, 1),
                      ),
                      child: const Text('Cancelar',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveCounter,
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(6),
                          ),
                        ),
                        backgroundColor: const Color.fromRGBO(81, 185, 214, 1),
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
      ),
    );
  }
}

class DailyGoalModalBoolean extends StatefulWidget {
  final int dailyId;
  final int habitId;

  const DailyGoalModalBoolean(
      {Key? key, required this.dailyId, required this.habitId})
      : super(key: key);

  @override
  _DailyGoalModalBooleanState createState() => _DailyGoalModalBooleanState();
}

class _DailyGoalModalBooleanState extends State<DailyGoalModalBoolean> {
  String? habitName;
  String? goalVsCurrent2;
  String? goal;
  String? value;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonUserString = prefs.getString('email');
    User? user;
    if (jsonUserString != null) {
      user = await UserController().getUserByEmail(jsonUserString);
    }

    Habit habit = await HabitController().getOneHabit(widget.habitId, user!.id);
    habitName = habit.name;

    DailyGoal daily = await DailyGoalController().getOneDaily(widget.dailyId);
    if (daily.booleanS != null) {
      debugPrint('aquiiiiiii');
      if (daily.booleanS!.goal == true) {
        goal = 'sim';
      } else {
        goal = 'não';
      }
    }

    setState(() {});
  }

  void _changeToTrue() {
    setState(() {
      value = 'sim';
    });
  }

  void _changeToFalse() {
    setState(() {
      value = 'não';
    });
  }

  void _saveCounter() {
    if (value == 'sim') {
      debugPrint('aqui3');
      DailyGoalController().updateBoolean(widget.dailyId, true);
    } else {
      debugPrint('aqui4');
      DailyGoalController().updateBoolean(widget.dailyId, false);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 100),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (habitName != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        habitName!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    child: ElevatedButton(
                      onPressed: _changeToFalse,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(255, 71, 117, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 48, // Ajuste a altura para corresponder aos botões
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "$value / $goal",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    child: ElevatedButton(
                      onPressed: _changeToTrue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(81, 185, 214, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Icon(Icons.check, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            if (value != null) ...[
              Text(
                value!,
                style: const TextStyle(fontSize: 16),
              ),
            ],
            const SizedBox(height: 16),
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
                        backgroundColor: const Color.fromRGBO(255, 71, 117, 1),
                      ),
                      child: const Text('Cancelar',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveCounter,
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(6),
                          ),
                        ),
                        backgroundColor: const Color.fromRGBO(81, 185, 214, 1),
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
      ),
    );
  }
}

void showDailyGoalModal(BuildContext context, int dailyId, int habitId) async {
  final prefs = await SharedPreferences.getInstance();
  String? jsonUserString = prefs.getString('email');
  User? user;
  if (jsonUserString != null) {
    user = await UserController().getUserByEmail(jsonUserString);
  }

  if (user != null) {
    Habit habit = await HabitController().getOneHabit(habitId, user.id);
    debugPrint(habit.goalKind.toString());

    if (habit.goalKind == TypeLabel.quantidade) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DailyGoalModal(dailyId: dailyId, habitId: habitId);
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DailyGoalModalBoolean(dailyId: dailyId, habitId: habitId);
        },
      );
    }
  }
}
