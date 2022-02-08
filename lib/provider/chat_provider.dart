import 'package:chatti/Widgets/Enum.dart';
import 'package:chatti/models/user_model.dart';
import 'package:chatti/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final user = FirebaseFirestore.instance.collection("Users");
  final notifications = FirebaseFirestore.instance.collection('Notifications');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  BlockStates blockStates = BlockStates.blockbyme;
  String myuserId = FirebaseAuth.instance.currentUser.uid;
  UserModel userdata;
  Stream message;
  String userId;










  void chatInit({@required UserModel userdata}) {
    userId = userdata.userId;
    this.userdata = userdata;
    getBlockStatus();
    getchats();
  }

  ///check block staus
  void getBlockStatus() async {
    bool myBlock = (await user.doc(_auth.currentUser.uid).get())['blockList']
        .contains(userId);

    bool isBlock = (await user.doc(userId).get())['blockList']
        .contains(_auth.currentUser.uid);

    if (myBlock && isBlock) {
      blockStates = BlockStates.blockbyme;
    } else if (myBlock && !isBlock) {
      blockStates = BlockStates.blockbyme;
    } else if (!myBlock && isBlock) {
      blockStates = BlockStates.blockbyuser;

      bool apology = (await user.doc(userId).get())['apologyList']
          .contains(_auth.currentUser.uid);

      if (apology) {
        blockStates = BlockStates.apologies;
      }
    } else {
      blockStates = BlockStates.none;
    }

    notifyListeners();
  }




  ///load chats
  Future<void> getchats() async {
    message = await DatabaseMethods(uid: _auth.currentUser.uid).getMessages(
      isuserID: userId,
    );
  }

  void sendapology() async {
    blockStates = BlockStates.apologies;
    await user.doc(userId).update({
      "apologyList": FieldValue.arrayUnion([_auth.currentUser.uid])
    }).whenComplete(() async {
      await notifications.doc(userId).collection("Notifications").doc().set({
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
    notifyListeners();
  }

  void blockuser() async {
    blockStates = BlockStates.blockbyme;
    await user.doc(_auth.currentUser.uid).update({
      "blockList": FieldValue.arrayUnion([userId])
    });
    getBlockStatus();
    notifyListeners();
  }

  void unblockuser() async {
    blockStates = BlockStates.none;
    await user.doc(_auth.currentUser.uid).update({
      "blockList": FieldValue.arrayRemove([userdata.userId])
    });
    getBlockStatus();
    notifyListeners();
  }



}
