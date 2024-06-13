class User {
  final int id;
  final String name;
  final String email;
  final String password;

  const User({required this.id, required this.name, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'name': String name, 'email': String email, 'password': String password} =>
        User(id: id, name: name, email: email, password: password),
      _ => throw const FormatException('Failed to load user.'),
    };
  }
}
