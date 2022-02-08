import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/material.dart';
import 'apology.dart';
import 'friendship.dart';

class Notifications extends StatelessWidget {
  const Notifications({
    Key key,
    @required this.notificationType,
    @required this.type,
    @required this.profileUrl,
    @required this.isuserId,
    @required this.myuserID,
    @required this.name,
    @required this.id,
    @required this.gender,
    @required this.timestamp,
    @required this.active,
    @required this.onprofile,
  }) : super(key: key);

  final String notificationType,
      isuserId,
      myuserID,
      name,
      id,
      gender,
      timestamp,
      profileUrl,
      type,
      active;
  final VoidCallback onprofile;

  @override
  Widget build(BuildContext context) {
    notificationContaint() {
      if (notificationType == "FRIENDSHIP") {
        if (type == "request") {
          return Friendship(
            myuserID: myuserID,
            name: name,
            type: type,
            id: id,
            profileUrl: profileUrl,
            timestamp: timestamp,
            decline: () {},
            isuserID: isuserId,
            active: active,
            onprofile: onprofile,
          );
        } else if (type == "accepted") {
          return Friendship(
            myuserID: myuserID,
            name: name,
            type: type,
            id: id,
            profileUrl: profileUrl,
            timestamp: timestamp,
            decline: () {},
            isuserID: isuserId,
            active: active,
            onprofile: onprofile,
          );
        } else {
          return Container();
        }
      } else if (notificationType == "CHAT") {
        if (type == "apology") {
          return Apology(
            myuserID: myuserID,
            name: name,
            type: type,
            id: id,
            profileUrl: profileUrl,
            timestamp: timestamp,
            decline: () {},
            isuserID: isuserId,
            gender: gender,
          );
        }
        // else if (type == "request") {
        //   return Container();
        // }
        else {
          return Container();
        }
      } else {
        return Container();
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kkDefaultPadding * 0.75),
      child: Row(
        children: [
          Flexible(child: notificationContaint()),
        ],
      ),
    );
  }
}
