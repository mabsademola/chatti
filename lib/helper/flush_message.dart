import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushMessage {
  final String title;
  final String message;
  final IconData icon;
  final Color color;

  const FlushMessage({
    this.title,
    this.message,
    this.icon,
    this.color,
  });

  void show(BuildContext context) {
    Flushbar(
        title: title != null ? title : null,
        message: message,
        padding: const EdgeInsets.all(10),
        // borderRadius: BorderRadius.circular(2),
        icon: Icon(
          icon,
          size: 30,
          color: color,
        ),
        duration: const Duration(seconds: 3),
        boxShadows: <BoxShadow>[
          const BoxShadow(
            color: Colors.black54,
            offset: Offset(2, 2),
            blurRadius: 4,
            spreadRadius: 1,
          )
        ])
      ..show(context);
  }
}
