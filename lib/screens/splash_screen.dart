import 'dart:async';

import 'package:chatti/provider/getdata_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatti/service/route.dart';
import 'package:provider/provider.dart';

import 'auth/onboarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimeout() {
    return new Timer(Duration(seconds: 2), handleTimeout);
  }

  void handleTimeout() {
    changeScreen();
  }

  changeScreen() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => buildFutureBuilder(),
        ));
  }

  changeScreento() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnBoardingPage(),
        ));
  }

  @override
  void initState() {
    var state = Provider.of<GetDataProvider>(context, listen: false);
    super.initState();
    startTimeout();
  }

  //  @override
  // void initState() {
  //   // getMyInfoFromSharedPreference();
  //   var state = Provider.of<GetDataProvider>(context, listen: false);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // decoration:  BoxDecoration(
          //       gradient:  LinearGradient(
          //           colors: [
          //              Theme.of(context).colorScheme.secondary,
          //             Theme.of(context).secondaryHeaderColor,
          //             Theme.of(context).primaryColor
          //           ],
          //           begin: Alignment.topRight,
          //           end: Alignment.bottomRight,
          //           stops: [0.0, 0.35, 1.0])),
          child: Center(
              child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            CupertinoIcons.chat_bubble_text_fill,
            //color: Colors.white,
            size: 60.0,
          ),
          SizedBox(width: 10.0),
          Text(
            "Chatti",
            style: TextStyle(
              fontSize: 60.0,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
              // color: Colors.white
            ),
          )
        ],
      ))),
    );
  }
// checkUser() async {

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool firsttimer = prefs.getBool("firsttime") ?? true ;

//     if (firsttimer == true) {
//      await prefs.setBool("firsttime", false);
//      changeScreento();
//     } else{
//       changeScreen();
//     }

//   }

}
