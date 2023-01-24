import 'package:flutter/material.dart';

enum Weekdays {
  monday(name: 'Lunes'),
  tuesday(name: 'Martes'),
  wednesday(name: 'Miercoles'),
  thursday(name: 'Jueves'),
  friday(name: 'Viernes'),
  saturday(name: 'Sabado'),
  sunday(name: 'Domingo'),
  holiday(name: 'Festivos');

  const Weekdays({required this.name});

  final String name;
}

class Weekday {
  Weekday(
    this.weekday, {
    this.openTime = const TimeOfDay(hour: 8, minute: 0),
    this.closeTime = const TimeOfDay(hour: 20, minute: 0),
  });

  final Weekdays weekday;
  TimeOfDay openTime;
  TimeOfDay closeTime;

  static final weekdays = Weekdays.values.map((e) => Weekday(e)).toList();

  @override
  bool operator ==(covariant Weekday other) {
    if (identical(this, other)) return true;
    return other.weekday == weekday;
  }

  @override
  int get hashCode => weekday.hashCode;

  @override
  String toString() => 'Weekday(weekday: $weekday, openTime: $openTime, closeTime: $closeTime)';
}
