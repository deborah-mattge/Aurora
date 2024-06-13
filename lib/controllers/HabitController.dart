import 'package:aurora/models/Habit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HabitController extends ChangeNotifier {

  Future<void> postHabits(String name, String colorTag, TypeLabel typeLabel,  periodLabel, String reference, String finishDate, String meta) async {
    Map<String, dynamic> habit = {
      "name": name,
      "reference": reference,
      "habitCategory": periodLabel.toString().split('.').last,
      "goalKind": typeLabel.toString().split('.').last,
      "color": colorTag,
      "finalDate": finishDate,
      "goal" : meta,
      "user": {"id": 1}
    };

    String jsonHabit = jsonEncode(habit);

    var url = 'http://10.0.2.2:8092/habit';
    var headers = {'Content-Type': 'application/json'};

    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonHabit);

    if (response.statusCode == 200) {
      debugPrint('Hábito postado com sucesso!');
    } else {
      debugPrint('Falha ao postar hábito: ${response.body}');
    }
    notifyListeners();
  }

  Future<List<Habit>> getHabits(num id) async {
    var url = 'http://10.0.2.2:8092/habit/user/$id';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);
  var decodedData = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      debugPrint('GET DE HÁBITO FUNCIONANDO!');
      final responseJson = jsonDecode(decodedData);
      List<Habit> habitsList = [];
      for (var habitFor in responseJson) {
        habitsList.add(Habit.fromJson(habitFor));
      }
      return habitsList;
    } else {
      debugPrint('FALHA AO DAR GET EM HÁBITOS: ${response.statusCode} ');
      return [];
    }
  }

  Future<Habit> getOneHabit(num habitId, num userId) async {
        debugPrint("$habitId");

    var url = 'http://10.0.2.2:8092/habit/$habitId/user/$userId';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);
          var decodedData = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      debugPrint('GET DE HÁBITO FUNCIONANDO!');
      final responseJson = jsonDecode(decodedData);
      return Habit.fromJson(responseJson);
    } else {
      debugPrint(
          'FALHA AO DAR GET EM HÁBITO: ${response.statusCode}  ');
      throw Exception('Failed to load habit');
    }
  }

  Future<void> updateHabit(
      int habitId,
      String habitName,
      String reference,
      PeriodLabel period,
      TypeLabel typeLabel,
      Color color,
      String parse) async {
    Map<String, dynamic> habit = {
      "id": habitId,
      "name": habitName,
      "reference": reference,
      "habitCategory": period.toString().split('.').last,
      "goalKind": typeLabel.toString().split('.').last,
      "color": '#${color.value.toRadixString(16).padLeft(8, '0')}',
      "finalDate": parse
    };

    String jsonHabit = jsonEncode(habit);

    var url = 'http://10.0.2.2:8092/habit/update';
    var headers = {'Content-Type': 'application/json'};

    var response =
        await http.patch(Uri.parse(url), headers: headers, body: jsonHabit);

    if (response.statusCode == 200) {
      debugPrint('Hábito editado com sucesso!');
    } else {
      debugPrint('Falha ao editar hábito: ${response.body}');
    }
    notifyListeners();
  }

  Future<List<Habit>> getHabitsByCategory(
      int userId, PeriodLabel category) async {
    List<Habit> allHabits = await getHabits(userId);
    return allHabits.where((habit) => habit.habitCategory == category).toList();
  }

  Future<void> deleteHabit(int id) async {
    var url = 'http://10.0.2.2:8092/habit/$id';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.delete(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      debugPrint('Hábito deletado com sucesso!');
    } else {
      debugPrint('Falha ao deletar hábito: ${response.body}');
    }
    notifyListeners();
  }
}
