import 'dart:async';

import 'package:chatti/Widgets/Enum.dart';
import 'package:chatti/dialogs/dialog.dart';

import 'package:chatti/models/menu.dart';
import 'package:chatti/models/user_model.dart';

import 'package:chatti/provider/chat_provider.dart';
import 'package:chatti/screens/Report/reportuser.dart';

import 'package:chatti/screens/Userprofile/pro.dart';
import 'package:chatti/services/database.dart';
import 'package:chatti/util/loadings.dart';
import 'package:chatti/util/profile_avatar.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'components/blocks.dart';

import 'components/message.dart';

class MessagesScreen extends StatefulWidget {
  @required
  final UserModel user;

  MessagesScreen({
    this.user,
  });

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with WidgetsBindingObserver {
  Stream messageStream;

  StreamSubscription<QuerySnapshot> deliveryStream;
  final FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseMethods db = DatabaseMethods();
  CustomLoader loader = CustomLoader();
  Dialogs dia = Dialogs();

  //testing
  final user = FirebaseFirestore.instance.collection("Users");
  final notifications = FirebaseFirestore.instance.collection('Notifications');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  BlockStates blockStates = BlockStates.none;
  // String myuserId = FirebaseAuth.instance.currentUser.uid;

  Stream message;
  // String userId;

  void chatInit() {
    getBlockStatus();
    getAndSetMessages();
    getDelivery();
    setState(() {});
  }

  ///check block staus
  void getBlockStatus() async {
    bool myBlock = (await user.doc(_auth.currentUser.uid).get())['blockList']
        .contains(widget.user.userId);

    bool isBlock = (await user.doc(widget.user.userId).get())['blockList']
        .contains(_auth.currentUser.uid);

    if (myBlock && isBlock) {
      blockStates = BlockStates.blockbyme;
    } else if (myBlock && !isBlock) {
      blockStates = BlockStates.blockbyme;
    } else if (!myBlock && isBlock) {
      blockStates = BlockStates.blockbyuser;

      bool apology = (await user.doc(widget.user.userId).get())['apologyList']
          .contains(_auth.currentUser.uid);

      if (apology) {
        blockStates = BlockStates.apologies;
      }
    } else {
      blockStates = BlockStates.none;
    }

    setState(() {});
  }

  void sendapology() async {
    blockStates = BlockStates.apologies;
    await user.doc(widget.user.userId).update({
      "apologyList": FieldValue.arrayUnion([_auth.currentUser.uid])
    }).whenComplete(() async {
      await notifications
          .doc(widget.user.userId)
          .collection("Notifications")
          .doc()
          .set({
        "notificationType": "CHAT",
        'type': 'apology',
        'timestamp': DateTime.now().microsecondsSinceEpoch,
        'sentBy': _auth.currentUser.uid,
        'status': 'sent',
      });
      // await DatabaseMethods(uid: userId)
      // .updateUserNotifi(read: false);
    });
    getBlockStatus();
    setState(() {});
  }

  blockuser() async {
    blockStates = BlockStates.blockbyme;
    await user.doc(_auth.currentUser.uid).update({
      "blockList": FieldValue.arrayUnion([widget.user.userId])
    });
    setState(() {});
    getBlockStatus();
  }

  unblockuser() async {
    blockStates = BlockStates.none;
    await user.doc(_auth.currentUser.uid).update({
      "blockList": FieldValue.arrayRemove([widget.user.userId])
    });
    getBlockStatus();
    setState(() {});
  }

  List<Choice> choices = const <Choice>[
    const Choice(
      title: 'Report',
      icon: CupertinoIcons.exclamationmark_triangle,
      id: 1,
    ),
    const Choice(
      title: 'Block',
      icon: Icons.block,
      id: 2,
    ),
    const Choice(
      title: 'Delete Chat',
      icon: CupertinoIcons.trash,
      id: 3,
    ),
  ];

  getAndSetMessages() async {
    messageStream =
        await DatabaseMethods(uid: auth.currentUser.uid).getMessages(
      isuserID: widget.user.userId,
    );
    setState(() {});
  }

  getDelivery() async {
    deliveryStream = FirebaseFirestore.instance
        .collection('Messages')
        .doc(widget.user.userId)
        .collection("Chats")
        .doc(auth.currentUser.uid)
        .collection("Chats")
        .where('isread', isEqualTo: false)
        .snapshots()
        .listen((event) {
      event.docs.every((element) {
        FirebaseFirestore.instance
            .collection('Messages')
            .doc(widget.user.userId)
            .collection("Chats")
            .doc(auth.currentUser.uid)
            .collection("Chats")
            .doc(element.id)
            .update({'isread': true});
        return true;
      });
    });
  }

  // void getBlockStatus() async {
  //   var isBlock1 = (await FirebaseFirestore.instance
  //           .collection("Users")
  //           .doc(auth.currentUser.uid)
  //           .get())['blockList']
  //       .contains(widget.user.userId);

  //   var isBlock2 = (await FirebaseFirestore.instance
  //           .collection("Users")
  //           .doc(widget.user.userId)
  //           .get())['blockList']
  //       .contains(auth.currentUser.uid);

  //   isBlock = isBlock1;
  //   myBlock = isBlock2;
  //   setState(() {});
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      switch (state) {
        case AppLifecycleState.resumed:
          print("resume");
          DatabaseMethods().updateMyChatListValues(
              auth.currentUser.uid, widget.user.userId, true);
          DatabaseMethods(uid: auth.currentUser.uid).updateActive(
              active: "online",
              lastSeen: DateTime.now().millisecondsSinceEpoch);
          // getDelivery();

          break;
        case AppLifecycleState.inactive:
          print("inactive");
          DatabaseMethods().updateMyChatListValues(
              auth.currentUser.uid, widget.user.userId, false);
          DatabaseMethods(uid: auth.currentUser.uid).updateActive(
              active: "offline",
              lastSeen: DateTime.now().millisecondsSinceEpoch);
          break;
        case AppLifecycleState.paused:
          print("paused");
          DatabaseMethods().updateMyChatListValues(
              auth.currentUser.uid, widget.user.userId, false);
          DatabaseMethods(uid: auth.currentUser.uid).updateActive(
              active: "away", lastSeen: DateTime.now().millisecondsSinceEpoch);
          break;
        case AppLifecycleState.detached:
          DatabaseMethods(uid: auth.currentUser.uid).updateActive(
              active: "offline",
              lastSeen: DateTime.now().millisecondsSinceEpoch);

          break;
      }
    });
  }

  // sendapology() async {
  //   var apology = (await FirebaseFirestore.instance
  //           .collection("Users")
  //           .doc(auth.currentUser.uid)
  //           .get())['blockList']
  //       .contains(widget.user.userId);

  //   apology
  //       ? await FirebaseFirestore.instance
  //           .collection("Users")
  //           .doc(auth.currentUser.uid)
  //           .update({
  //           "apologyList": FieldValue.arrayUnion([widget.user.userId])
  //         }).whenComplete(() async {
  //           await db.notifications
  //               .doc(widget.user.userId)
  //               .collection("Notifications")
  //               .doc()
  //               .set({
  //             "notificationType": "CHAT",
  //             'type': 'apology',
  //             'timestamp': DateTime.now().microsecondsSinceEpoch,
  //             'sentBy': auth.currentUser.uid,
  //             'status': 'sent',
  //           });
  //           await DatabaseMethods(uid: widget.user.userId)
  //               .updateUserNotifi(read: false);
  //         })
  //       : null;
  // }

  @override
  void dispose() {
    deliveryStream.cancel();

    // isShowLocalNotification = false;
    DatabaseMethods().updateMyChatListValues(
        auth.currentUser.uid, widget.user.userId, false);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    chatInit();

      WidgetsBinding.instance.addObserver(this);
    DatabaseMethods()
        .updateMyChatListValues(auth.currentUser.uid, widget.user.userId, true);
  }

  @override
  Widget build(BuildContext context) {
    final chatState = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
        appBar: buildAppBar(chatState),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding * 0.5),
                child: chatMessages(),
              ),
            ),
            ChatInputWidget(
              blockStates: blockStates,
              myuserId: _auth.currentUser.uid,
              sendapology: () {
                sendapology();
                setState(() {});
              },
              userdata: widget.user,
              unblock: () {
                unblockuser();
                setState(() {});
              },
            ),
          ],
        ));
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(

                // padding: EdgeInsets.only(bottom: 70, top: 16),
                itemCount: snapshot.data.docs.length,
                reverse: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  // if (ds['sentBy'] == auth.currentUser.uid &&
                  //     ds['isread'] == false) {
                  //   if (ds.reference != null) {
                  //     FirebaseFirestore.instance
                  //         .runTransaction((Transaction myTransaction) async {
                  //       await myTransaction
                  //           .update(ds.reference, {'isread': true});
                  //     });
                  //   }
                  // }
                  return ds["messageType"] == "TEXT"
                      ? Message(
                          messageType: ds["messageType"],
                          sentBy: ds["sentBy"],
                          imgUrl: widget.user.profilePic,
                          message: ds["text"],
                          myuserID: auth.currentUser.uid,
                          isuserID: widget.user.userId,
                          isread: ds["isread"],
                        )
                      : ds["messageType"] == "IMAGE"
                          ? Message(
                              messageType: ds["messageType"],
                              image: ds["image"],
                              isread: ds["isread"],
                              sentBy: ds["sentBy"],
                              imgUrl: widget.user.profilePic,
                              // message: ds["text"],
                              myuserID: auth.currentUser.uid,
                              isuserID: widget.user.userId,
                            )
                          : ds["messageType"] == "IMAGETEXT"
                              ? Message(
                                  messageType: ds["messageType"],
                                  image: ds["image"],
                                  message: ds["text"],
                                  isread: ds["isread"],
                                  sentBy: ds["sentBy"],
                                  imgUrl: widget.user.profilePic,
                                  // message: ds["text"],
                                  myuserID: auth.currentUser.uid,
                                  isuserID: widget.user.userId,
                                )
                              : Container();
                })
            : Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff191720).withOpacity(0.5),
                  ),
                  height: 200,
                  width: 200,
                  child: Center(
                    child: Text(
                      "Couldn't get details",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              );
      },
    );
  }

  AppBar buildAppBar(ChatProvider chat) {
    return AppBar(
      elevation: 5,
      // leadingWidth: 100,
      titleSpacing: 0,
      centerTitle: false,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          CupertinoIcons.chevron_back,
          // size: 24,
        ),
      ),
      title: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileScreen(user: widget.user
                      // widget.user.userId,
                      // widget.user.displayName,
                      // widget.userName,
                      // widget.user.profilePic,
                      // widget.gender,
                      // widget.dob,
                      // widget.about,
                      // widget.address,
                      // widget.location,
                      // widget.active,
                      )));
        },
        child: Container(
          child: Row(
            children: [
              ProfileAvatar(
                imageUrl: widget.user.profilePic,
                radius: 20,
              ),
              SizedBox(width: kDefaultPadding * 0.75),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.displayName,
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    "Active 3m ago",
                    style: TextStyle(fontSize: 13),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      actions: [
        PopupMenuButton<Choice>(
          elevation: 0,
          color: Colors.transparent,
          onSelected: (choice) {
            if (choice.id == 1) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Report()));
            } else if (choice.id == 2) {
              dia.showblock(
                  context: context,
                  isname: widget.user.displayName,
                  block: () {
                    blockuser();
                    Navigator.pop(context);
                  });
            } else if (choice.id == 3) {
              dia.clearmsg(
                  context: context,
                  isname: widget.user.displayName,
                  clearbutton: () async {
                    FirebaseFirestore.instance
                        .collection('Messages')
                        .doc(auth.currentUser.uid)
                        .collection("Chats")
                        .doc(widget.user.userId)
                        .collection("Chats")
                        .get()
                        .then((snapshot) {
                      for (DocumentSnapshot ds in snapshot.docs) {
                        ds.reference.delete();
                      }
                      FirebaseFirestore.instance
                          .collection('Messages')
                          .doc(auth.currentUser.uid)
                          .collection("Chatlist")
                          .doc(widget.user.userId)
                          .delete();
                    });

                    Navigator.pop(context);
                  });
            }
          },

          // grey.withOpacity(0.7),

          icon: Icon(
            CupertinoIcons.ellipsis_vertical_circle,
          ),
          itemBuilder: (BuildContext context) {
            return choices.map((Choice choice) {
              // myBlock ? null: null;
              return PopupMenuItem<Choice>(
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
        SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
}
