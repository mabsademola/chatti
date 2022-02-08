import 'package:flutter/material.dart';
import 'package:chatti/extensions/text_extension.dart';
import 'package:chatti/screens/Profile/components/circular_image.dart';
import 'package:chatti/services/database.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Apology extends StatefulWidget {
  const Apology({
    Key key,
    @required this.myuserID,
    @required this.isuserID,
    @required this.type,
    @required this.profileUrl,
    @required this.gender,
    @required this.name,
    @required this.decline,
    @required this.id,
    @required this.timestamp,
  }) : super(key: key);

  final String myuserID,
      id,
      isuserID,
      gender,
      profileUrl,
      type,
      timestamp,
      name;
  final VoidCallback decline;

  @override
  _ApologyState createState() => _ApologyState();
}

class _ApologyState extends State<Apology> {
  DatabaseMethods db = DatabaseMethods();

  unblock() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.myuserID)
        .update({
      "blockList": FieldValue.arrayRemove([widget.isuserID])
    }).whenComplete(
      () async {
        await db.notifications
            .doc(widget.myuserID)
            .collection("Notifications")
            .doc(widget.id)
            .delete();
        await DatabaseMethods(uid: widget.isuserID)
            .updateUserNotifi(read: false);
        await db.notifications
            .doc(widget.isuserID)
            .collection("Notifications")
            .doc()
            .set({
          "notificationType": "CHAT",
          'type': 'unblocked',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'sentBy': widget.myuserID,
          'status': 'sent',
        });
      },
    );
  }

  decline() async {
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
            CircularImage(path: widget.profileUrl, height: 50),
            // if (chat.isActive)
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
            // if (!chat.isActive)
            //   Positioned(
            //     right: 0,
            //     bottom: 0,
            //     child: Container(
            //       height: 18,
            //       width: 18,
            //       decoration: BoxDecoration(
            //         color: kErrorColor,
            //         shape: BoxShape.circle,
            //         border: Border.all(
            //             color: Theme.of(context).scaffoldBackgroundColor,
            //             width: 3),
            //       ),
            //     ),
            //   ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        widget.type == "apology"
            ? Expanded(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${textdo(widget.name)} sent an apology to please unblock ${genderdo(widget.gender)}"),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 40.0,
                              width: 100.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Text(
                                  'Unblock',
                                  style: TextStyle(),
                                ),
                                onPressed: () {
                                  unblock();
                                },
                                color: Theme.of(context).colorScheme.secondary,
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
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                child: Text(
                                  "Decline",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),

                                // color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            : widget.type == "unblocked"
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            "${textdo(widget.name)} accepted your apology to be unblocked"),
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
