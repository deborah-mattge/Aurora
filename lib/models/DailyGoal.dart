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
}
