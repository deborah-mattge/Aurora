class Quantity {
  final int id;
  late final int currentStatus;
  final int goal;

  Quantity({required this.id, required this.currentStatus, required this.goal});

  factory Quantity.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'currentStatus': int currentStatus, 'goal': int goal} =>
        Quantity(id: id, currentStatus: currentStatus, goal: goal),
      _ => throw const FormatException('Failed to load user.'),
    };
  }
}