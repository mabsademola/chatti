import 'dart:async';

import 'package:chatti/models/personal_model.dart';
import 'package:chatti/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

class DatabaseMethods {
  final String uid;
  static DatabaseMethods get instanace => DatabaseMethods();

  DatabaseMethods({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("Users");
  final user = FirebaseFirestore.instance.collection("Users");
  final contact = FirebaseFirestore.instance.collection("Friends");
  final cloudReference = FirebaseFirestore.instance.collection('Cloud');
  final notifications = FirebaseFirestore.instance.collection('Notifications');
  final messages = FirebaseFirestore.instance.collection('Messages');
  // String get chatID => null;

  PersonalModel _listFromDocument(DocumentSnapshot doc) {
    return PersonalModel(
        userId: doc['userId'],
        displayName: doc['displayName'],
        userName: doc['userName'],
        profilePic: doc['profilePic'],
        gender: doc['gender'],
        dob: doc['dob'],
        about: doc['about'],
        address: doc['address'],
        location: doc['location']['geopoint'],
        active: doc['active']);
  }

  //get user data
  Stream<PersonalModel> get userData {
    return user.doc(uid).snapshots().map(_listFromDocument);
  }

// search user by name
  Future<Stream<QuerySnapshot>> getUserByname(String name) async {
    return FirebaseFirestore.instance
        .collection('Users')
        .limit(10)
        .where("displayName", isGreaterThanOrEqualTo: name.toLowerCase())
        .snapshots();
  }

  // search user by name
  Future getUserByuid(String uidd) async {
    return FirebaseFirestore.instance
        .collection('Users')
        .where("userId", isEqualTo: uidd)
        .snapshots();
  }

  // get all users to explore screen
  Future<Stream<QuerySnapshot>> getAllUsers() async {
    return FirebaseFirestore.instance
        .collection("Users")
        .orderBy("createdAt")
        .snapshots();
  }

  // get all users to explore screen
  Future<Stream<QuerySnapshot>> getAllNotifications() async {
    return notifications
        .doc(uid)
        .collection("Notifications")
        .orderBy("timestamp")
        .snapshots();

    // snapshots();
  }

  // check or create chatroom
  createChats(String chatID) async {
    return messages.doc(uid).collection("Chats").doc(chatID).get();
  }

  Future<void> updateMyChatListValues(
      //TODO
      String userID,
      String isuserId,
      bool isread) async {
    var updateData =
        isread ? {'read': isread, 'badgeCount': 0} : {'read': isread};
    final DocumentReference result =
        messages.doc(userID).collection("Chatlist").doc(isuserId);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(result);
      if (!snapshot.exists) {
        transaction.set(result, updateData);
      } else {
        transaction.update(result, updateData);
      }
    });
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(documentID)
    //     .collection('chatlist')
    //     .doc(chatID)
    //     .set(updateData);
    int unReadMSGCount =
        await DatabaseMethods.instanace.getUnreadMSGCount(userID);
    FlutterAppBadger.updateBadgeCount(unReadMSGCount);
  }

  Future<void> updateActive({
    String active,
    var lastSeen,
  }) async {
    var updateData = {'active': active, 'lastSeen': lastSeen};
    final DocumentReference result =
        FirebaseFirestore.instance.collection("Users").doc(uid);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(result);
      if (!snapshot.exists) {
        transaction.set(result, updateData);
      } else {
        transaction.update(result, updateData);
      }
    });
  }

  Future updateNoteList(String userID, bool read) async {
    var notifiBadgeCount = 0;
    var read = false;

    DocumentSnapshot userDoc = await messages.doc(userID).get();

    if (userDoc.data() != null) {
      if (userDoc != null
          //  && userID != myID
          ) {
        notifiBadgeCount = userDoc['notifiBadgeCount'];
        notifiBadgeCount++;
      }
    } else {
      notifiBadgeCount++;
    }

    await messages.doc(userID).set({
      'notifiBadgeCount': read ? 0 : notifiBadgeCount,
    });
  }

  Future updateUserNotifi({@required bool read}) async {
    var userBadgeCount = 0;
    var read = false;

    DocumentSnapshot userDoc = await notifications.doc(uid).get();

    if (userDoc.data() != null) {
      // read = userDoc.get('read') ?? false;
      if (userDoc != null) {
        userBadgeCount = userDoc['badgeCount'];
        userBadgeCount++;
      }
    } else {
      userBadgeCount++;
    }

    await notifications.doc(uid).set({
      'badgeCount': read ? 0 : userBadgeCount,
    });
  }

  Future updateUserChatListField(
      {String documentID,
      String chatID,
      String myuserId,
      String lastMessage,
      String selectedUserID,
      messageType}) async {
    var userBadgeCount = 0;
    var read = false;

    DocumentSnapshot userDoc =
        await messages.doc(documentID).collection('Chatlist').doc(chatID).get();

    if (userDoc.data() != null) {
      read = userDoc.get('read') ?? false;
      if (userDoc != null && documentID != myuserId && !userDoc['read']) {
        userBadgeCount = userDoc['badgeCount'];
        userBadgeCount++;
      }
    } else {
      userBadgeCount++;
    }

    await messages.doc(documentID).collection('Chatlist').doc(chatID).set({
      // 'chatID': chatID,
      'chatWith': selectedUserID,
      'sentBy': myuserId,
      'lastChat': lastMessage,
      'badgeCount': read ? 0 : userBadgeCount,
      "messageType": messageType,
      'read': read,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    });
  }

  Future<Stream<QuerySnapshot>> chatCount() async {
    return messages
        .doc(uid)
        .collection("Chatlist")
        .where("read", isEqualTo: "false")
        .snapshots();
  }

//Delete chats
  deleteChat(String isuserId) async {}

//get block status
  getBlockStatus(String isuserId) async {
    var isBlocked = (await FirebaseFirestore.instance
            .collection("Users")
            .doc(isuserId)
            .get())['blockList']
        .contains(uid);

    return isBlocked;
  }

  getRequestStatus(
      {String ownerID,
      String displayName,
      String userDp,
      String userID,
      String sentBy}) async {
    return notifications
        .doc(ownerID)
        .collection('Notifications')
        //.document(senderEmail)
        .where('sentBy', isEqualTo: sentBy)
        // .get();
        .where('type', isEqualTo: 'request')
        .snapshots();
  }

  Future<int> getUnreadMSG(String peerUserID) async {
    try {
      int unReadMSGCount = 0;
      QuerySnapshot userChatList = await FirebaseFirestore.instance
          .collection('Users')
          .doc(peerUserID)
          .collection('Chatlist')
          .get();
      List<QueryDocumentSnapshot> chatListDocuments = userChatList.docs;
      for (QueryDocumentSnapshot snapshot in chatListDocuments) {
        unReadMSGCount = unReadMSGCount + snapshot['badgeCount'];
      }
      print('unread MSG count is $unReadMSGCount');
      return unReadMSGCount;
    } catch (e) {
      print(e.message);
    }
  }

  // Future reportUser(
  //   String userID,
  //   myID,
  // ) async {
  //   try {
  //     return FirebaseFirestore.instance
  //         .collection('Report_Users')
  //         .doc(userID)
  //         .collection("report")
  //         .doc(myID)
  //         .set({
  //      'Report': chatID,
  //       'timestamp': DateTime.now().millisecondsSinceEpoch
  //     });
  //   } catch (e) {}
  // }

  Future<int> getUnreadMSGCount(String peerUserID) async {
    try {
      int unReadMSGCount = 0;
      QuerySnapshot userChatList =
          await messages.doc(peerUserID).collection('Chatlist').get();
      List<QueryDocumentSnapshot> chatListDocuments = userChatList.docs;
      for (QueryDocumentSnapshot snapshot in chatListDocuments) {
        unReadMSGCount = unReadMSGCount + snapshot['badgeCount'];
      }
      print('unread MSG count is $unReadMSGCount');
      return unReadMSGCount;
    } catch (e) {
      print(e.message);
    }
  }

  Future<int> getUnreadNotifiCount(String peerUserID) async {
    try {
      int unReadMSGCount = 0;
      QuerySnapshot userChatList =
          await messages.doc(peerUserID).collection('Chatlist').get();
      List<QueryDocumentSnapshot> chatListDocuments = userChatList.docs;
      unReadMSGCount = userChatList.docs.length;
      print('unread MSG count is $unReadMSGCount');
      return unReadMSGCount;
    } catch (e) {
      print(e.message);
    }
  }

//add message to database
  Future sendMessage({
    //  String chatID,
    // String userID,
    String isuserID,
    Map messageInfo,
  }) async {
    return messages
        .doc(uid)
        .collection("Chats")
        .doc(isuserID)
        .collection("Chats")
        .doc()
        .set(messageInfo);
  }

  Future<Stream<QuerySnapshot>> getMessages({isuserID}) async {
    return messages
        .doc(uid)
        .collection("Chats")
        .doc(isuserID)
        .collection("Chats")
        .orderBy("timeSent", descending: true)
        .snapshots();
  }

  // search user by username
  Future<Stream<QuerySnapshot>> getAllUser() async {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }

// get all users to explore screen
  Future<Stream<QuerySnapshot>> getchatlists() async {
    return messages
        .doc(uid)
        .collection("Chatlist")
        .orderBy("timestamp")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getfriendlists() async {
    return contact
        .doc(uid)
        .collection("Friends")
        .where("type", isEqualTo: "accepted")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getprofile() async {
    return user.where('userId', isEqualTo: uid).snapshots();
  }
}
