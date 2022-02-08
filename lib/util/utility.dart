import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

int countChatListUsers(myID, AsyncSnapshot<QuerySnapshot> snapshot) {
  int resultInt = snapshot.data.docs.length;
  for (var data in snapshot.data.docs) {
    if (data['userId'] == myID) {
      resultInt--;
    }
  }
  return resultInt;
}
