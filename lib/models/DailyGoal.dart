import 'package:aurora/models/BooleanType.dart';
import 'package:aurora/models/Habit.dart';
import 'package:aurora/models/Quantity.dart';

class DailyGoal {
  final int id;
  final DateTime day;
  final Quantity? quantity;
  final BooleanType? booleanS;
  final Habit? habit;

  const DailyGoal(
      {required this.id, required this.day, required this.habit, this.quantity, this.booleanS});

  factory DailyGoal.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int? ?? -1;
    final day = DateTime.parse(json['day']);
    final quantity =
        json['quantity'] != null ? Quantity.fromJson(json['quantity']) : null;
    final booleanS = json['booleanType'] != null
        ? BooleanType.fromJson(json['booleanS'])
        : null;
    final habit = json['habit'] != null
        ? Habit.fromJson(json['habit'])
        : null;

    return DailyGoal(id: id, day: day, habit: habit, quantity: quantity, booleanS: booleanS);
  }
}
