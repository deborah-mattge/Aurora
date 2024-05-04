import 'package:aurora/models/ENUM/goal_kind.dart';
import 'package:aurora/models/ENUM/habit_category.dart';
import 'package:aurora/models/UserModel.dart';

class Habit {
  int? id;
  String? name;
  User? user;
  String? color;
  HabitCategory? habitCategory;
  GoalKind? goalKind;
  DateTime? finalDate;
  String? reference;

  Habit({
    this.id,
    this.name,
    this.user,
    this.habitCategory,
    this.color,
    this.goalKind,
    this.finalDate,
    this.reference,
  });

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'] as int,
      name: json['name'] as String,
      user: User.fromJson(json['user']), // Assuming User has a fromJson method
      color: json['color'] as String,
      habitCategory: _parseHabitCategory(json['habitCategory'] as String),
      goalKind: _parseGoalKind(json['goalKind'] as String),
      finalDate: DateTime.parse(json['finalDate']
          as String), // Assuming finalDate is in ISO 8601 format
      reference: json['reference'] as String?,
    );
  }

  static HabitCategory _parseHabitCategory(String category) {
    switch (category.toLowerCase()) {
      case 'morning':
        return HabitCategory.MORNING;
      case 'afternoon':
        return HabitCategory.AFTERNOON;
      case 'evening':
        return HabitCategory.EVENING;
      case 'everyday':
        return HabitCategory.EVERYDAY;
      default:
        throw ArgumentError('Invalid habit category: $category');
    }
  }

  static GoalKind _parseGoalKind(String goalKind) {
    switch (goalKind.toLowerCase()) {
      case 'boolean':
        return GoalKind.BOOLEAN;
      case 'quantity':
        return GoalKind.QUANTITY;
      case 'time':
        return GoalKind.TIME;
      default:
        throw ArgumentError('Invalid goal kind: $goalKind');
    }
  }
}
