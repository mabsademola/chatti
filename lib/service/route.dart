import 'package:chatti/screens/auth/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatti/screens/screens.dart';

getCurrentUser() async {
  return FirebaseAuth.instance.currentUser;
}

FutureBuilder buildFutureBuilder() {
  return FutureBuilder(
    future: getCurrentUser(),
    builder: (context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        return Navigation();
      } else {
        return OnBoardingPage();
      }
    },
  );
}
