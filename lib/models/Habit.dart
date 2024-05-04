class Habit {
  final int id;
  final String name;
  final String color;

  const Habit({required this.id, required this.name, required this.color});

  factory Habit.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'name': String name, 'color': String color} =>
        Habit(id: id, name: name, color: color),
      _ => throw const FormatException('Failed to load habit.'),
    };
  }
}
