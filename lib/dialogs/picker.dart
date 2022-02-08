import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Picker {
  static void showSheet(
    BuildContext context, {
    @required Widget child,
    @required VoidCallback onpress,
    InputDecoration decoration,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            child,
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Done'),
            onPressed: onpress,
          ),
        ),
      );

  static void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(fontSize: 24)),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
