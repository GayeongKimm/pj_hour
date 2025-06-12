import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:hour/component/theme/color.dart';

class FlushbarUtil {
  static void show(
      BuildContext context,
      String message, {
        Color color = HourColors.red,
        Duration duration = const Duration(seconds: 2),
        FlushbarPosition position = FlushbarPosition.TOP,
      }) {
    Flushbar(
      message: message,
      duration: duration,
      backgroundColor: color,
      flushbarPosition: position,
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }
}