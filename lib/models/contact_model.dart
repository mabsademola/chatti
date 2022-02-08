import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  String userId;
  String type;

  ContactModel({
    this.userId,
    this.type,
  });

  factory ContactModel.fromDocument(DocumentSnapshot doc) {
    return doc != null
        ? ContactModel(
            userId: doc['userId'],
            type: doc['type'],
          )
        : null;
  }
}
