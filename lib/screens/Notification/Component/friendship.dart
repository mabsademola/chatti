import 'package:chatti/extensions/text_extension.dart';
import 'package:chatti/screens/Profile/components/circular_image.dart';
import 'package:chatti/services/database.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Friendship extends StatefulWidget {
  const Friendship({
    Key key,
    @required this.myuserID,
    @required this.isuserID,
    @required this.type,
    @required this.profileUrl,
    @required this.name,
    @required this.decline,
    @required this.id,
    @required this.timestamp,
    @required this.onprofile,
    @required this.active,
  }) : super(key: key);

  final String myuserID,
      id,
      isuserID,
      profileUrl,
      type,
      timestamp,
      name,
      active;
  final Function decline;
  final Function onprofile;
  @override
  _FriendshipState createState() => _FriendshipState();
}

class _FriendshipState extends State<Friendship> {
  DatabaseMethods db = DatabaseMethods();
  String type;
  bool _delecting = false;

  addfriend() async {
    if (this.mounted) {
      setState(() {
        _delecting = true;
      });
    }
    await FirebaseFirestore.instance
        .collection("Friends")
        .doc(widget.myuserID)
        .collection("Friends")
        .doc(widget.isuserID)
        .set({
      "userId": widget.isuserID,
      "type": "accepted",
    });
    await DatabaseMethods(uid: widget.isuserID).updateUserNotifi(read: false);
    await FirebaseFirestore.instance
        .collection("Friends")
        .doc(widget.isuserID)
        .collection("Friends")
        .doc(widget.myuserID)
        .set({
      "userId": widget.myuserID,
      "type": "accepted",
    }).whenComplete(() {
      db.notifications
          .doc(widget.myuserID)
          .collection("Notifications")
          .doc(widget.id)
          .delete();

      db.notifications
          .doc(widget.isuserID)
          .collection("Notifications")
          .doc()
          .set({
        "notificationType": "FRIENDSHIP",
        'type': 'accepted',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'sentBy': widget.myuserID,
        'status': 'sent',
      });
    });
  }

  decline() async {
    if (this.mounted) {
      setState(() {
        _delecting = true;
      });
    }
    await db.notifications
        .doc(widget.myuserID)
        .collection("Notifications")
        .doc(widget.id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            GestureDetector(
                onTap: widget.onprofile,
                child: CircularImage(path: widget.profileUrl, height: 50)),
            if (widget.active == "online")
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    color: kOnlineColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 3),
                  ),
                ),
              ),
            if (widget.active == "offline")
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    color: kContentColorDarkTheme,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 3),
                  ),
                ),
              ),
            if (widget.active == "away")
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 3),
                  ),
                ),
              ),
            if (widget.active == null)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    color: kContentColorDarkTheme,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 3),
                  ),
                ),
              ),
            // Positioned(
            //   right: 0,
            //   bottom: 0,
            //   child: Container(
            //     height: 118,
            //     width: 118,
            //     decoration: BoxDecoration(
            //       color: kOnlineColor,
            //       shape: BoxShape.circle,
            //       border: Border.all(
            //           color: Theme.of(context).scaffoldBackgroundColor,
            //           width: 3),
            //     ),
            //   ),
            // ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        widget.type == "request"
            ? Expanded(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${textdo(widget.name)} sent you a friend request"),
                        SizedBox(
                          height: 10,
                        ),
                        !_delecting
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 40.0,
                                    width: 100.0,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Text(
                                        'Accept',
                                        style: TextStyle(),
                                      ),
                                      onPressed: () {
                                        addfriend();
                                        setState(() {
                                          _delecting = true;
                                        });
                                      },
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 40.0,
                                    width: 100.0,
                                    child: OutlineButton(
                                      onPressed: () {
                                        decline();
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      child: Text(
                                        "Decline",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),

                                      // color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Expanded(
                                      child: Container(
                                        height: 40.0,
                                        padding: const EdgeInsets.all(10.0),
                                        // width: 100.0,
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child:
                                              const CircularProgressIndicator(
                                                  strokeWidth: 2.0,
                                                  color: Colors.white),
                                          // Text(
                                          //   'Please Wait',
                                          //   style: TextStyle(),
                                          // ),
                                          onPressed: () {},
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                      ],
                    )
                  ],
                ),
              )
            : widget.type == "accepted"
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            "${textdo(widget.name)} accepted your friend request"),
                        SizedBox(
                          height: 5,
                        ),
                        Opacity(
                          opacity: 0.64,
                          child: Text(widget.timestamp),
                        ),
                      ],
                    ),
                  )
                : Container()
      ],
    );
  }
}
