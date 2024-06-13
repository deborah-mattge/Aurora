import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Habit {
  final int id;
  final String name;
  final PeriodLabel habitCategory;
  final TypeLabel goalKind;
  final Color color;
  final String reference;
  final DateTime finalDate;

  const Habit(
      {required this.id,
      required this.name,
      required this.color,
      required this.habitCategory,
      required this.goalKind,
      required this.reference,
      required this.finalDate});

  factory Habit.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException('JSON data is null');
    }

    final id = json['id'] as int? ?? -1;
    final name = json['name'] as String? ?? '';
    final colorStr = json['color'] as String? ?? '';
    final periodLabelStr = json['habitCategory'] as String?;
    final typeLabelStr = json['goalKind'] as String?;
    final reference = json['reference'] as String? ?? '';
    final finalDateStr = json['finalDate'] as String;
    debugPrint(periodLabelStr);
    debugPrint(typeLabelStr);

    if (periodLabelStr == null || typeLabelStr == null) {
      throw FormatException('One or more required fields are missing');
    }

    final periodLabel = _parsePeriodLabel(periodLabelStr);
    final typeLabel = _parseTypeLabel(typeLabelStr);
    final color = _parseColor(colorStr);
    final finalDate = _parseLocalDateTime(finalDateStr);

    return Habit(
        id: id,
        name: name,
        color: color,
        habitCategory: periodLabel,
        goalKind: typeLabel,
        reference: reference,
        finalDate: finalDate);
  }

  static DateTime _parseLocalDateTime(String localDateTimeStr) {
    final format = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    return format.parse(localDateTimeStr);
  }

  static Color _parseColor(String color) {
    switch (color) {
      case '#ff51b9d6':
        return const Color.fromRGBO(81, 185, 214, 1.0);
      case '#ffff4775':
        return const Color.fromRGBO(255, 71, 117, 1.0);
      case '#ffa26bd8':
        return const Color.fromRGBO(162, 107, 216, 1.0);
      case '#ff7ace78':
        return const Color.fromRGBO(122, 206, 120, 1.0);
      default:
        throw FormatException('Invalid color: $color');
    }
  }

  static PeriodLabel _parsePeriodLabel(String label) {
    switch (label) {
      case 'noturno':
        return PeriodLabel.noturno;
      case 'matutino':
        return PeriodLabel.matutino;
      case 'vespertino':
        return PeriodLabel.vespertino;
      case 'diario':
        return PeriodLabel.diario;
      default:
        throw FormatException('Invalid period label: $label');
    }
  }

  static TypeLabel _parseTypeLabel(String label) {
    switch (label) {
      case 'booleano':
        return TypeLabel.booleano;
      case 'quantidade':
        return TypeLabel.quantidade;
      case 'tempo':
        return TypeLabel.tempo;
      default:
        throw FormatException('Invalid type label: $label');
    }
  }
}

enum PeriodLabel {
  noturno,
  matutino,
  vespertino,
  diario,
}

enum TypeLabel {
  booleano,
  quantidade,
  tempo,
}
