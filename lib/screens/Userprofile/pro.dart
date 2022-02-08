// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatti/extensions/text_extension.dart';
import 'package:chatti/extensions/title_text.dart';

import 'package:chatti/helper/utility.dart';
import 'package:chatti/models/user_model.dart';

import 'package:chatti/provider/location_provider.dart';
import 'package:chatti/screens/Messages/message_screen.dart';
import 'package:chatti/screens/Report/reportuser.dart';
import 'package:chatti/services/database.dart';
import 'package:chatti/util/customWidgets.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../imageviewer_screen.dart';

class ProfileScreen extends StatefulWidget {
  @required
  final UserModel user;

  ProfileScreen({this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 0;
  int friendlength = 0;
  Utility utility = Utility();
  String type;
  // bool sentrequest = false;
  // bool acceptedrequest = false;
  // bool checkfriendss = false;
  // bool friends = false;
  DatabaseMethods db = DatabaseMethods();
  Stream notificationsStream, friendsStream;

  getfriends() async {
    friendsStream =
        await DatabaseMethods(uid: widget.user.userId).getfriendlists();
    // friendlength = friendsStream.length;

    setState(() {});
  }

  void openunfriends() {
    openBottomSheet(
      context,
      150,
      Column(
        children: <Widget>[
          SizedBox(height: 5),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Color.fromRGBO(101, 118, 133, 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 10),
          //   child: TitleText('Upload Photo'),
          // ),
          Divider(height: 0),
          InkWell(
            onTap: () {
              unfriend();
              Navigator.pop(context);
            },
            child: _row(
              // icon: buildIcons("menu_groups"),
              text: "Unfriend",
            ),
          ),
          Divider(height: 0),

          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: _row(
              icon: Icon(
                Icons.close,
                // color: Colors.white,
              ),
              text: "Cancel",
            ),
          ),
        ],
      ),
    );
  }

  void opencancelrequest() {
    openBottomSheet(
      context,
      150,
      Column(
        children: <Widget>[
          SizedBox(height: 5),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Color.fromRGBO(101, 118, 133, 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 10),
          //   child: TitleText('Upload Photo'),
          // ),
          Divider(height: 0),
          InkWell(
            onTap: () {
              cancelrequest();
              Navigator.pop(context);
              // sendrequest();
            },
            child: _row(
              // icon: buildIcons("menu_invite"),
              text: "Cancel Request",
            ),
          ),
          Divider(height: 0),

          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: _row(
              icon: Icon(
                Icons.close,
                // color: Colors.white,
              ),
              text: "Cancel",
            ),
          ),
        ],
      ),
    );
  }





  Widget buildIcons(
    String assetName, {
    double width = 24,
  }) {
    return Image.asset('assets/images/icons/$assetName.png', width: width);
  }

  Widget check(String type) {
    return type == "accepted"
        ? _buttonn(
            icon: "menu_groups",
            onpress: () {
              openunfriends();
            },
          )
        : type == "request"
            ? _buttonn(
                icon: "msg_invited",
                onpress: () {
                  opencancelrequest();
                },
                tooltip: "Tap to cancel request")
            : _buttonn(
                icon: "menu_invite",
                onpress: () {
                  request();
                },
                tooltip: "Tap to send request");
  }





  Widget _row({
    String text,
    Icon icon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      child: ListTile(
        // leading: Container(
        //   padding: const EdgeInsets.all(10),
        //   // height: 25,
        //   //  width: 50,

        //   child: IconButton(
        //     color: kPrimaryColor,
        //     icon: icon,
        //     onPressed: null,
        //     // tooltip: tooltip,
        //   ),

        //   decoration: BoxDecoration(
        //     color: kPrimaryColor.withOpacity(0.1),
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        // ),
        // // onTap:tap,
        title: TitleText(text),
        // controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  void openBottomSheet(
    BuildContext context,
    double height,
    Widget child,
  ) async {
    await showModalBottomSheet(
      // backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: height,
          decoration: BoxDecoration(
            // color: TwitterColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: child,
        );
      },
    );
  }

  void checkfrendship() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("Friends")
        .doc(auth.currentUser.uid)
        .collection("Friends")
        .doc(widget.user.userId)
        .get();
    if (doc.exists) {
      type = doc["type"];
      print(type);
    }

    setState(() {});
  }

  unfriend() async {
    print('unfriends');
    if (this.mounted) {
      setState(() {
        type = "";
      });
    }
    await FirebaseFirestore.instance
        .collection("Friends")
        .doc(widget.user.userId)
        .collection("Friends")
        .doc(auth.currentUser.uid)
        .get()
        .then((value) {
      FirebaseFirestore.instance
          .collection("Friends")
          .doc(auth.currentUser.uid)
          .collection("Friends")
          .doc(widget.user.userId)
          .delete();
    });
    await FirebaseFirestore.instance
        .collection("Friends")
        .doc(auth.currentUser.uid)
        .collection("Friends")
        .doc(widget.user.userId)
        .get()
        .then((value) {
      FirebaseFirestore.instance
          .collection("Friends")
          .doc(auth.currentUser.uid)
          .collection("Friends")
          .doc(widget.user.userId)
          .delete();
    });

    // await FirebaseFirestore.instance
    //     .collection("Users")
    //     .doc(auth.currentUser.uid)
    //     .update({
    //   "friendsList": FieldValue.arrayRemove([widget.user.userId])
    // }).whenComplete(() {
    //   getfriends();
    //   checkfrendship();
    // });

    // await FirebaseFirestore.instance
    //     .collection("Users")
    //     .doc(widget.user.userId)
    //     .update({
    //   "friendsList": FieldValue.arrayRemove([auth.currentUser.uid])
    // });
    // await FirebaseFirestore.instance
    //     .collection("Users")
    //     .doc(auth.currentUser.uid)
    //     .update({
    //   "friendsList": FieldValue.arrayRemove([widget.user.userId])
    // }).whenComplete(() {

    //   getfriends();
    //   checkfrendship();
    // });

    db.notifications
        .doc(auth.currentUser.uid)
        .collection("Notifications")
        .doc(widget.user.userId)
        .get()
        .then((snapshot) {
      db.notifications
          .doc(auth.currentUser.uid)
          .collection("Notifications")
          .doc(widget.user.userId)
          .delete();
    });
  }

  cancelrequest() async {
    print('friends request retracted');
    if (this.mounted) {
      setState(() {
        type = "";
      });
    }
    await FirebaseFirestore.instance
        .collection("Friends")
        .doc(widget.user.userId)
        .collection("Friends")
        .doc(auth.currentUser.uid)
        .get()
        .then((value) {
      FirebaseFirestore.instance
          .collection("Friends")
          .doc(auth.currentUser.uid)
          .collection("Friends")
          .doc(widget.user.userId)
          .delete();
    });
    db.notifications
        .doc(widget.user.userId)
        .collection("Notifications")
        .doc(auth.currentUser.uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  request() async {
    print('friends request sent');
    if (this.mounted) {
      setState(() {
        type = "request";
      });
    }

    FirebaseFirestore.instance
        .collection("Friends")
        .doc(auth.currentUser.uid)
        .collection("Friends")
        .doc(widget.user.userId)
        .set({
      "userId": widget.user.userId,
      "type": "request",
    }).then((value) async {
      await db.notifications
          .doc(widget.user.userId)
          .collection("Notifications")
          .doc()
          .set({
        "notificationType": "FRIENDSHIP",
        'type': 'request',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'sentBy': auth.currentUser.uid,
        'status': 'sent',
      });
      await DatabaseMethods(uid: widget.user.userId)
          .updateUserNotifi(read: false);
    });

    // checkfrendship();
  }

  Widget _entry(
    String title,
    String model,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: Column(
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Opacity(
                  opacity: 0.8,
                  child: customText(
                    title,
                    style: TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(width: 50),
              Expanded(
                child: Text(
                  model,
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
          Divider(height: 2)
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    var state = Provider.of<LocationProvider>(context, listen: false);
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.user.displayName,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (widget.user.active == "online")
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: kOnlineColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    if (widget.user.active == "offline")
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: kContentColorDarkTheme,
                          shape: BoxShape.circle,
                        ),
                      ),
                    if (widget.user.active == "away")
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    if (widget.user.active == null)
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: kContentColorDarkTheme,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Opacity(
                  opacity: 0.40,
                  child: Text(
                    "@" + widget.user.userName,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _button(
                      icon: Icon(
                        CupertinoIcons.chat_bubble_text,
                      ),
                      onpress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MessagesScreen(
                                      user: widget.user,
                                     
                                    )));
                      },
                      tooltip: "Message"),
                  check(type),
                  _button(
                      icon: Icon(CupertinoIcons.star_lefthalf_fill),
                      onpress: () async {
                        GFToast.showToast(
                            "This feature is currently disabled", context,
                            toastPosition: GFToastPosition.BOTTOM,
                            textStyle:
                                TextStyle(fontSize: 13, color: GFColors.DARK),
                            backgroundColor: GFColors.LIGHT,
                            trailing: Icon(
                              CupertinoIcons.exclamationmark_circle_fill,
                              color: GFColors.INFO,
                            ));
                      },
                      tooltip: "Rate Chatti"),
                  _button(
                      icon: Icon(
                        CupertinoIcons.share_up,
                      ),
                      onpress: () {
                        GFToast.showToast(
                            "This feature is currently disabled", context,
                            toastPosition: GFToastPosition.BOTTOM,
                            textStyle:
                                TextStyle(fontSize: 13, color: GFColors.DARK),
                            backgroundColor: GFColors.LIGHT,
                            trailing: Icon(
                              CupertinoIcons.exclamationmark_circle_fill,
                              color: GFColors.INFO,
                            ));
                        // utility.share(
                        //   username: widget.user.userName,
                        //   displayname: widget.user.displayName,
                        // );
                      },
                      tooltip: "Share Profile"),
                ],
              ),
            ),

            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 120,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    widget.user.about,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            // HeaderWidget(
            //   'User Detail',
            // ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.placemark,
                    // color: Colors.white,
                    size: 20,
                  ),
                  state.getDistance(widget.user.location) == null
                      ? Text(
                          "Unkown",
                          style: TextStyle(
                              // color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        )
                      : Text(
                          state.getDistance(widget.user.location),
                          style: TextStyle(
                              // color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                ],
              ),
            ),

            widget.user.dob != null
                ? _entry('Gender', widget.user.gender)
                : Container(),

            widget.user.dob != null
                ? _entry(
                    'Address',
                    widget.user.address,
                  )
                : Container(),

            widget.user.dob != null
                ? _entry('Date of Birth', widget.user.dob.substring(0, 6))
                : Container(),
          ],
        ));
  }

  @override
  void initState() {
    getfriends();
    // getdistance();
    // sendrequest();
    checkfrendship();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .70;
    _panelHeightClosed = MediaQuery.of(context).size.height * 0.42;
    return Scaffold(
      body: Stack(
        children: [
          SlidingUpPanel(
            color: kContentColorLightTheme,
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
            body: Stack(
              children: [
                _body(context),
              ],
            ),
            panelBuilder: (sc) => _panel(sc),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    // height: 25,
                    //  width: 50,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                Container(
                  // height: 25,
                  //  width: 50,
                  child: PopupMenuButton<_choice>(
                    elevation: 0,
                    color: Colors.transparent,

                    onSelected: (choice) {
                      if (choice.id == 1) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Report()));
                      } else {}
                    },

                    // grey.withOpacity(0.7),

                    icon: Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                    itemBuilder: (BuildContext context) {
                      return choices.map((_choice choice) {
                        return PopupMenuItem<_choice>(
                          value: choice,
                          child: Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(choice.icon),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    choice.title,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList();
                    },
                  ),

                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Imageviewer(
                      imageUrl: widget.user.profilePic,
                    )));
      },
      child: Container(
        // width: 100,
        height: MediaQuery.of(context).size.height * 0.60,
        width: MediaQuery.of(context).size.width,
        // child: Center(
        //   child: Hero(
        //     tag: widget.user.profilePic,
        //     child: CachedNetworkImage(
        //       imageUrl: widget.user.profilePic,
        //       placeholder: (context, url) => Container(
        //         // height: height,
        //         // width: height,
        //         child: Image.asset(
        //           widget.user.gender == "Male"
        //               ? 'assets/images/pro/img_default_avatar_man.png'
        //               : 'img_default_avatar_woman.png',
        //           fit: BoxFit.cover,
        //           // height: height,
        //           // width: height,
        //         ),
        //       ),
        //       errorWidget: (context, url, error) => Image.asset(
        //         widget.user.gender == "Male"
        //             ? 'assets/images/pro/img_default_avatar_man.png'
        //             : 'img_default_avatar_woman.png',
        //         fit: BoxFit.cover,
        //         // height: height,
        //         // width: height,
        //       ),
        //       fit: BoxFit.fill,
        //       // height: height,
        //       // width: height,
        //     ),
        //   ),
        // ),

        decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                  widget.user.profilePic,
                ),
                fit: BoxFit.cover)),
      ),
    );
  }
}

Widget _button({
  Icon icon,
  VoidCallback onpress,
  String tooltip,
}) {
  return Container(
    padding: const EdgeInsets.all(3),
    child: IconButton(
      color: kPrimaryColor,
      icon: icon,
      onPressed: onpress,
      tooltip: tooltip,
    ),
    decoration: BoxDecoration(
      color: kPrimaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

Widget _buttonn({
  String icon,
  VoidCallback onpress,
  String tooltip,
}) {
  return Container(
    padding: const EdgeInsets.all(7),
    child: InkWell(
      onTap: onpress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildIcons(icon),
      ),
    ),
    // IconButton(
    //   color: kPrimaryColor,
    //   icon: icon,
    //   onPressed: onpress,
    //   tooltip: tooltip,
    // ),
    decoration: BoxDecoration(
      color: kPrimaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

// ignore: camel_case_types
class _choice {
  const _choice({this.title, this.icon, this.id});

  final IconData icon;
  final String title;
  final int id;
}

const List<_choice> choices = const <_choice>[
  const _choice(
    title: 'Report User',
    icon: CupertinoIcons.exclamationmark_triangle,
    id: 1,
  ),
];
