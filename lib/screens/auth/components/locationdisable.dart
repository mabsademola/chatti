import 'package:chatti/Widgets/text_fields.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Locationdis extends StatefulWidget {
  const Locationdis({Key key}) : super(key: key);

  @override
  _LocationdisState createState() => _LocationdisState();
}

class _LocationdisState extends State<Locationdis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Disable"),
      ),
      body: Center(
        child: Column(
          children: [
            Icon(
              CupertinoIcons.location,
              size: 100,
            ),
            Text("Location Permission Wasn't Granted"),
            Text("We need your location in order to display nearby people "),
            MyTextButton(
              buttonName: 'Grant Permission',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
