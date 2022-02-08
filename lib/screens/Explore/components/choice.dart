// ignore: camel_case_types
// ignore_for_file: camel_case_types, unnecessary_const

import 'package:flutter/cupertino.dart';

class _choice {
  const _choice({this.title, this.icon, this.id});

  final IconData icon;
  final String title;
  final int id;
}

const List<_choice> choices = const <_choice>[
  const _choice(
    title: 'Based On Location',
    icon: CupertinoIcons.placemark,
    id: 1,
  ),
  const _choice(
    title: 'Based On Recommedation',
    icon: CupertinoIcons.rectangle_grid_2x2,
    id: 2,
  ),
];
