import 'package:cloud_firestore/cloud_firestore.dart';

class NotifiModel {
  String notificationType;
  String sentBy;
  String type;
  String status;
  int timestamp;
  String id;

  NotifiModel(
      {this.notificationType,
      this.sentBy,
      this.type,
      this.status,
      this.timestamp,this.id});

  factory NotifiModel.fromDocument(DocumentSnapshot doc) {
    return doc != null
        ? NotifiModel(
            notificationType: doc['notificationType'],
            sentBy: doc['sentBy'],
            type: doc['type'],
            status: doc['status'],
            timestamp: doc['timestamp'],
             id: doc.id,
            
          )
        : null;
  }
}
