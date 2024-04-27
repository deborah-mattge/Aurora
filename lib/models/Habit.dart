import 'package:aurora/models/ENUM/habit_category.dart';

class Habit {
  int id;
  String name;
  String color;
  HabitCategory habitCategory;

  Habit({
    required this.id,
    required this.name,
    required this.habitCategory,
    required this.color,
  });
  
  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'] as int,
      name: json['name'] as String,
      color: json['color'] as String,
      habitCategory: _parseHabitCategory(json['habitCategory'] as String),
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
}
