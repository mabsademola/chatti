import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;

  const HeaderWidget(
    this.title, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 12, right: 12, bottom: 10, top: 25),
        alignment: Alignment.centerLeft,
        child: Text(
          title ?? '',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ));
  }
}
