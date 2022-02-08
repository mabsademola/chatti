import 'package:chatti/Widgets/shimmers.dart';
import 'package:chatti/helper/utility.dart';
import 'package:chatti/models/listchat.dart';
import 'package:chatti/models/user_model.dart';
import 'package:chatti/screens/Messages/message_screen.dart';
import 'package:chatti/screens/Report/reportuser.dart';
import 'package:chatti/screens/Userprofile/pro.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../chat_card.dart';

class Details extends StatefulWidget {
  const Details({
    Key key,
    @required this.ds,
  }) : super(key: key);

  final ListChatModel ds;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Stream userdata;
   final FirebaseAuth auth = FirebaseAuth.instance;

  //  Future<void> getData() async {
  //   await Future<dynamic>.delayed(const Duration(milliseconds: 0));
  //   return true;
  // }

  Future<void> getDetails() async {
    userdata = await FirebaseFirestore.instance
        .collection('Users')
        .where('userId', isEqualTo: widget.ds.chatWith)
        .snapshots();

    // userdata = await FirebaseFirestore.instance
    //     .collection('Users')
    //     .where('userId', isEqualTo: widget.userId)
    //     .snapshots();

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
        builder: (context, chatListSnapshot) {
          var ser =
              chatListSnapshot.hasData ? chatListSnapshot.data.docs[0] : null;

          UserModel user = UserModel.fromDocument(ser);

          return user != null
              ? Slidable(
                  actionExtentRatio: 0.15,
                  actionPane: SlidableDrawerActionPane(),
                  child: ChatCard(
                      active: ser["active"],
                      profileUrl: ser["profilePic"],
                      name: ser["displayName"],
                      userName: widget.ds.lastChat ?? ser["about"],
                      read: widget.ds.read,
                      // isuserid: widget.ds.chatWith,
                      isuserid: widget.ds.chatWith,
                      myuserid:auth.currentUser.uid,
                      timestamp: Utility().readTimestamp(widget.ds.timestamp),
                      badgeCount: widget.ds.badgeCount == 0
                          ? null
                          : widget.ds.badgeCount,
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessagesScreen(
                                user: user,
                              ),
                            ));
                      }),
                  actions: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: SlideAction(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MessagesScreen(
                                        user: user,
                                      )));
                        },
                        decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.1),
                            shape: BoxShape.circle),
                        child: Icon(
                          CupertinoIcons.chat_bubble_text,
                          color: kPrimaryColor,
                          size: 25.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: SlideAction(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProfileScreen(user: user)));
                          },
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.1),
                              shape: BoxShape.circle),
                          child: Icon(
                            CupertinoIcons.person,
                            color: kPrimaryColor,
                            size: 25.0,
                          )),
                    ),
                  ],
                  secondaryActions: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: SlideAction(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Report()));
                        },
                        decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.1),
                            shape: BoxShape.circle),
                        child: Icon(
                          CupertinoIcons.exclamationmark_triangle,
                          color: kPrimaryColor,
                          size: 25.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: SlideAction(
                        onTap: () {
                          {
                            FirebaseFirestore.instance
                                .collection('Messages')
                                .doc(widget.ds.sentBy)
                                .collection("Chatlist")
                                .doc(widget.ds.chatWith)
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
              : const SingleListshimmer();
        });
  }
}
