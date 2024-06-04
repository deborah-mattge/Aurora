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

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyGoalModal extends StatefulWidget {
  final int dailyId;
  final int habitId;

  const DailyGoalModal({Key? key, required this.dailyId, required this.habitId}) : super(key: key);

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
      goalVsCurrent2 = "${daily.quantity!.currentStatus}/${daily.quantity!.goal}" + habit.reference;
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
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _decrementCounter,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Icon(Icons.remove),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      counter != null && goal != null ? "$counter / $goal" : '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _incrementCounter,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Icon(Icons.add),
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
                      child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
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
                      child: const Text('Salvar', style: TextStyle(color: Colors.white)),
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

// Para exibir o diálogo, use este código no lugar de firstdialogBuilder
void showDailyGoalModal(BuildContext context, int dailyId, int habitId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DailyGoalModal(dailyId: dailyId, habitId: habitId);
    },
  );
}

    // } else {
    //   return showDialog<void>(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         insetPadding: const EdgeInsets.symmetric(vertical: 100),
    //         backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
    //         content: SizedBox(
    //           width: MediaQuery.of(context).size.width * 0.8,
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(vertical: 8),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     SizedBox(
    //                       width: 150,
    //                       child: Text(
    //                         habitName,
    //                         style: const TextStyle(
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 18,
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(vertical: 8),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Expanded(
    //                       child: ElevatedButton(
    //                         onPressed: () {
    //                           DailyGoalController().updateBoolean(dailyId, false);
    //                         },
    //                         style: ElevatedButton.styleFrom(
    //                           shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(4),
    //                           ),
    //                           padding: const EdgeInsets.symmetric(vertical: 16),
    //                         ),
    //                         child: const Icon(Icons.close),
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       width: 80,
    //                       child: Text(
    //                         boolCurrent,
    //                         style: const TextStyle(
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 18,
    //                         ),
    //                       ),
    //                     ),
    //                     Expanded(
    //                       child: ElevatedButton(
    //                         onPressed: () {
    //                           DailyGoalController().updateBoolean(dailyId, true);
    //                         },
    //                         style: ElevatedButton.styleFrom(
    //                           shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(4),
    //                           ),
    //                           padding: const EdgeInsets.symmetric(vertical: 16),
    //                         ),
    //                         child: const Icon(Icons.check),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Text(
    //                 goalVsCurrent2,
    //                 style: const TextStyle(fontSize: 16),
    //               ),
    //               const SizedBox(height: 16),
    //               Container(
    //                 decoration: BoxDecoration(
    //                   border: Border(
    //                     top: BorderSide(color: Colors.grey.shade300),
    //                   ),
    //                 ),
    //                 child: Row(
    //                   children: [
    //                     Expanded(
    //                       child: ElevatedButton(
    //                         onPressed: () {
    //                           Navigator.of(context).pop();
    //                         },
    //                         style: ElevatedButton.styleFrom(
    //                           shape: const RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.only(
    //                               bottomLeft: Radius.circular(6),
    //                             ),
    //                           ),
    //                           backgroundColor:
    //                               const Color.fromRGBO(255, 71, 117, 1),
    //                         ),
    //                         child: const Text('Cancelar',
    //                             style: TextStyle(color: Colors.white)),
    //                       ),
    //                     ),
    //                     Expanded(
    //                       child: ElevatedButton(
    //                         onPressed: () {
    //                           DailyGoalController()
    //                               .updateQuantity(dailyId, counter);
    //                           Navigator.of(context).pop();
    //                         },
    //                         style: ElevatedButton.styleFrom(
    //                           shape: const RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.only(
    //                               bottomRight: Radius.circular(6),
    //                             ),
    //                           ),
    //                           backgroundColor:
    //                               const Color.fromRGBO(81, 185, 214, 1),
    //                         ),
    //                         child: const Text('Salvar',
    //                             style: TextStyle(color: Colors.white)),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   );


