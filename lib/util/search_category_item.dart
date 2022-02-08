import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/material.dart';

class CategoryStoryItem extends StatelessWidget {
  final String name;
  const CategoryStoryItem({
    Key key,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: white.withOpacity(0.2))),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            name,
            style: TextStyle(
                color: white, fontWeight: FontWeight.w500, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
