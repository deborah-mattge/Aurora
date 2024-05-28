class BooleanType {
  final int id;
  final bool currentStatus;
  final bool goal;

  BooleanType({required this.id, required this.currentStatus, required this.goal});

  factory BooleanType.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'currentStatus': bool currentStatus, 'goal': bool goal} =>
        BooleanType(id: id, currentStatus: currentStatus, goal: goal),
      _ => throw const FormatException('Failed to load user.'),
    };
  }
}