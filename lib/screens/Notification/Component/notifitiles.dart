import 'package:chatti/Widgets/shimmers.dart';
import 'package:chatti/extensions/text_extension.dart';
import 'package:chatti/helper/utility.dart';
import 'package:chatti/models/notification_model.dart';
import 'package:chatti/models/user_model.dart';
import 'package:chatti/screens/Userprofile/pro.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'notification.dart';

class Shownotification extends StatefulWidget {
  const Shownotification({
    Key key,
    @required this.notifi,
  }) : super(key: key);

  final NotifiModel notifi;

  @override
  State<Shownotification> createState() => _ShownotificationState();
}

class _ShownotificationState extends State<Shownotification> {
  Stream userdata;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final notifications = FirebaseFirestore.instance.collection('Notifications');

  Future<void> getDetails() async {
    userdata = await FirebaseFirestore.instance
        .collection('Users')
        .where('userId', isEqualTo: widget.notifi.sentBy)
        .snapshots();

    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getDetails();
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: userdata,
        builder: (context, nottSnapshot) {
          var ser = nottSnapshot.hasData ? nottSnapshot.data.docs[0] : null;
          UserModel user = UserModel.fromDocument(ser);
          return user != null
              ? Slidable(
                  actionExtentRatio: 0.15,
                  actionPane: SlidableDrawerActionPane(),
                  child: Notifications(
                    name: inCaps(user.displayName),
                    profileUrl: user.profilePic,
                    notificationType: widget.notifi.notificationType,
                    type: widget.notifi.type,
                    id: widget.notifi.id,
                    timestamp: Utility().readTimestamp(widget.notifi.timestamp),
                    isuserId: widget.notifi.sentBy,
                    myuserID: auth.currentUser.uid,
                    gender: ser["gender"],
                    active: ser["active"],
                    onprofile: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen(user: user)));
                    },
                  ),
                  secondaryActions: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: SlideAction(
                        onTap: () async {
                          {
                            await notifications
                                .doc(auth.currentUser.uid)
                                .collection("Notifications")
                                .doc(widget.notifi.id)
                                .delete();
                          }
                        },
                        decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.1),
                            shape: BoxShape.circle),
                        child: Icon(
                          CupertinoIcons.trash,
                          color: kPrimaryColor,
                          size: 25.0,
                        ),
                      ),
                    ),
                  ],
                )
              : SingleNotificationShimmer();
        });
  }
}
