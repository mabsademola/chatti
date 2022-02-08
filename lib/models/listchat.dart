import 'package:cloud_firestore/cloud_firestore.dart';


class ListChatModel {
  String chatWith;
  String sentBy;
  String lastChat;
  int badgeCount;
  dynamic messageType;
  bool read;
  int timestamp;

  ListChatModel({
    this.chatWith,
    this.sentBy,
    this.lastChat,
    this.badgeCount,
    this.messageType,
    this.read,
    this.timestamp,
  });

  factory ListChatModel.fromDocument(DocumentSnapshot doc) {
    return doc != null
        ? ListChatModel(
            chatWith: doc['chatWith'],
            sentBy: doc['sentBy'],
            lastChat: doc['lastChat'],
            badgeCount: doc['badgeCount'],
            messageType: doc['messageType'],
            read: doc['read'],
            timestamp: doc['timestamp'],
          )
        : null;
  }
}
