import 'package:chatti/Widgets/shimmers.dart';
import 'package:chatti/extensions/text_extension.dart';
import 'package:chatti/listtile/searchtile.dart';
import 'package:chatti/models/contact_model.dart';
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

class ContactDetails extends StatefulWidget {
  const ContactDetails({
    Key key,
    @required this.ds,
  }) : super(key: key);

  final ContactModel ds;

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  Stream userdata;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> getDetails() async {
    userdata = await FirebaseFirestore.instance
        .collection('Users')
        .where('userId', isEqualTo: widget.ds.userId)
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
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: userdata,
          builder: (context, chatListSnapshot) {
            var ser =
                chatListSnapshot.hasData ? chatListSnapshot.data.docs[0] : null;
            UserModel user = UserModel.fromDocument(ser);

            return user != null
                ? Slidable(
                    actionExtentRatio: 0.15,
                    actionPane: SlidableDrawerActionPane(),
                    child: UserTile(
                      profileUrl: ser["profilePic"],
                      name: inCaps(ser["displayName"]),
                      userName: ser["userName"],
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MessagesScreen(
                                      user: user,
                                    )));
                      },
                    ),
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
                    ],
                  )
                : SingleListshimmer();
          }),
    );
  }
}
