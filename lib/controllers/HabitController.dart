import 'package:aurora/models/Habit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HabitController extends ChangeNotifier {
  Future<void> _postHabits(String habitName) async {
    Map<String, dynamic> habit = {
      "name": habitName,
      "user": {"id": 1}
    };

    String jsonHabit = jsonEncode(habit);

    var url = 'http://10.0.2.2:8080/habit';

    var headers = {'Content-Type': 'application/json'};

    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonHabit);

    if (response.statusCode == 200) {
      debugPrint('Hábito postado com sucesso!');
    } else {
      debugPrint('Falha ao postar hábito');
    }
    notifyListeners();
  }

  Future<List<Habit>> getHabit() async {
    var url = 'http://10.0.2.2:8090/habit/user/1';
    var response = await http.get(Uri.parse(url));
    final decodedResponse = utf8.decode(response.bodyBytes);

    final responseJson = jsonDecode(decodedResponse);

    if (response.statusCode == 200) {
      debugPrint('GET DE HÁBITO FUNCIONANDO!');
    } else {
      debugPrint('FALHA AO DAR GET EM HÁBITO] ${response.statusCode}');
    }

    List<Habit> habitsList = [];

    for (var habitFor in responseJson) {
      habitsList.add(Habit.fromJson(habitFor));
    }
    debugPrint('$habitsList');
    return habitsList;
  }
}
