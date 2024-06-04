<<<<<<< HEAD
import 'package:aurora/models/Habit.dart';

class DailyGoal {
  int? id;
  DateTime? day;
  Habit? habit;
  Quantity? quantity;
  Time? time;
  BooleanType? booleanS;
  bool? done;

  DailyGoal({
    this.id,
    this.day,
    this.habit,
    this.quantity,
    this.time,
    this.booleanS,
    this.done,
  });

  factory DailyGoal.fromJson(Map<String, dynamic> json) {
    return DailyGoal(
      id: json['id'] as int?,
      day: json['day'] == null ? null : DateTime.parse(json['day'] as String),
      habit: json['habit'] == null ? null : Habit.fromJson(json['habit']),
      quantity: json['quantity'] == null ? null : Quantity.fromJson(json['quantity']),
      time: json['time'] == null ? null : Time.fromJson(json['time']),
      booleanS: json['booleanS'] == null ? null : BooleanType.fromJson(json['booleanS']),
      done: json['done'] as bool?,
    );
  }


}

class Quantity {
  int? amount;

  Quantity({this.amount});

  factory Quantity.fromJson(Map<String, dynamic> json) {
    return Quantity(
      amount: json['amount'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
    };
  }
}

class Time {
  int? hours;
  int? minutes;

  Time({this.hours, this.minutes});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      hours: json['hours'] as int?,
      minutes: json['minutes'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hours': hours,
      'minutes': minutes,
    };
  }
}

class BooleanType {
  bool? value;

  BooleanType({this.value});

  factory BooleanType.fromJson(Map<String, dynamic> json) {
    return BooleanType(
      value: json['value'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
=======
import 'package:aurora/models/BooleanType.dart';
import 'package:aurora/models/Quantity.dart';

class DailyGoal {
  final int id;
  final DateTime day;
  final Quantity? quantity;
  final BooleanType? booleanS;

  const DailyGoal({required this.id, required this.day, this.quantity, this.booleanS});

  factory DailyGoal.fromJson(Map<String, dynamic> json) {
     final id = json['id'] as int? ?? -1;
     final day = DateTime.parse(json['day']);
     final quantity = json['quantity'] != null ? Quantity.fromJson(json['quantity']) : null;
     final booleanS = json['booleanType'] != null ? BooleanType.fromJson(json['booleanS']) : null;
    
    return DailyGoal(
      id:id,
      day:day,
      quantity: quantity,
      booleanS: booleanS
    );
  }
>>>>>>> ac763772eac9dc4b716c1e029ba1a34cf3bfd7de
}
