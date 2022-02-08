// ignore: camel_case_types
import 'package:flutter/material.dart';

class Choice {
  const Choice({
    this.id,
    this.title,
    this.icon,
  });

  final IconData icon;
  final String title;
  final int id;
}
