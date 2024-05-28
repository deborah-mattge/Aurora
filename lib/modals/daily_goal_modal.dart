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

  Future<void> firstdialogBuilder(BuildContext context, int habitId) async {

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
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text("nome: "),
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

