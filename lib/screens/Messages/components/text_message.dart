import 'package:flutter/material.dart';
import 'package:chatti/utility.dart/theme.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    @required this.message,
    @required this.myuserID,
    @required this.sentBy,
  }) : super(key: key);

  final String message;
  final String myuserID;

  final String sentBy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 1.5,
        vertical: kDefaultPadding * 0.75,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(sentBy == myuserID ? 1 : 0.1),
        borderRadius: sentBy == myuserID ? radius() : radiuss(),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: sentBy == myuserID
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
    );
  }

  BorderRadius radius() {
    return BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(0),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20));
  }

  BorderRadius radiuss() {
    return BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(0));
  }
}
