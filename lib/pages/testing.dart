import 'dart:convert';

import 'package:aurora/controllers/DailyGoalController.dart';
import 'package:aurora/controllers/HabitController.dart';
import 'package:aurora/modals/daily_goal_modal.dart';
import 'package:aurora/modals/habits_modal.dart';
import 'package:aurora/modals/update_user_modal.dart';
import 'package:aurora/models/DailyGoal.dart';
import 'package:aurora/models/Habit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('showDialog Sample')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () => UpdateUserModal().firstdialogBuilder(context),
                child: const Text('Open User'),
              ),
              OutlinedButton(
                onPressed: () => HabitController().getHabits(2),
                child: const Text('Open Habits'),
              ),
            ],
          ),
          Expanded(
            child: BotaoLista(userId: 1),
          ),
          Expanded(
            child: DailyLista(habitId: 2)
          )
        ],
      ),
    );
  }
}

 class BotaoLista extends StatelessWidget {
  final int userId;

  BotaoLista({required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Habit>>(
      future: HabitController().getHabits(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No habits found.'));
        } else {
          final habits = snapshot.data!;
          return ListView.builder(
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              return OutlinedButton(
                onPressed: () => HabitsModal().firstdialogBuilder(context, habit.id),
                child: Text('Open Habit: ${habit.name}'),
              );
            },
          );
        }
      },
    );
  }
}

class DailyLista extends StatelessWidget {
  final int habitId;

  const DailyLista({required this.habitId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DailyGoal>>(
      future: DailyGoalController().getAll(habitId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No dailies found.'));
        } else {
          final dailies = snapshot.data!;
          return ListView.builder(
            itemCount: dailies.length,
            itemBuilder: (context, index) {
              final daily = dailies[index];
              return OutlinedButton(
                onPressed: () => showDailyGoalModal(context, daily.id, habitId),
                child: Text('Open Daily: ${daily.id}'),
              );
            },
          );
        }
      },
    );
  }
}






