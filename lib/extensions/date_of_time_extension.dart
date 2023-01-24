import 'package:flutter/material.dart';

extension DateOfTimeExtension on TimeOfDay {
  String get formated => '$hour:${minute < 10 ? '0$minute' : minute}';
}
