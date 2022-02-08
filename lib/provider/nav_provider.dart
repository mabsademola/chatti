
import 'package:chatti/models/personal_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  NavProvider() {
    getdata();
  }
  final user = FirebaseFirestore.instance.collection("Users");
  // final notifications = FirebaseFirestore.instance.collection('Notifications');
  final FirebaseAuth auth = FirebaseAuth.instance;
  // int chat = 0;
  // int noti = 0;
  PersonalModel personalModel;

  getdata() async {
    DocumentSnapshot ds = await user.doc(auth.currentUser.uid).get();
    personalModel = PersonalModel.fromDocument(ds);
    notifyListeners();
  }
}
