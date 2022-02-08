import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Utility {
  final url = "https://mabsshooter.blogspot.com/p/privacy-policy.html";
  share({
    String username,
    String displayname,
  }) {
    Share.share(
      "Checkout $displayname's profile on Chatti App, ${displayname}at ",
    );
  }

  void launchpolicy() async => await canLaunch(url) ? await launch(url) : null;

  report() {
    String encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'mabsshooter@gmail.com',
      query: encodeQueryParameters(
          <String, String>{'subject': 'A problem occured while using Chatti'}),
    );

    launch(emailLaunchUri.toString());
  }

  feedback() {
    String encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'mabsshooter@gmail.com',
      query:
          encodeQueryParameters(<String, String>{'subject': 'Chatti Feedback'}),
    );

    launch(emailLaunchUri.toString());
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      if (diff.inHours > 0) {
        time = diff.inHours.toString() + 'h ago';
      } else if (diff.inMinutes > 0) {
        time = diff.inMinutes.toString() + 'm ago';
      } else if (diff.inSeconds > 0) {
        time = 'now';
      } else if (diff.inMilliseconds > 0) {
        time = 'now';
      } else if (diff.inMicroseconds > 0) {
        time = 'now';
      } else {
        time = 'now';
      }
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = diff.inDays.toString() + 'd ago';
    } else if (diff.inDays > 6) {
      time = (diff.inDays / 7).floor().toString() + 'w ago';
    } else if (diff.inDays > 29) {
      time = (diff.inDays / 30).floor().toString() + 'm ago';
    } else if (diff.inDays > 365) {
      time = '${date.month}-${date.day}-${date.year}';
    }
    return time;
  }

  String readActive(int timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      if (diff.inHours > 0) {
        time = 'Active' + diff.inHours.toString() + 'h ago';
      } else if (diff.inMinutes > 20) {
        time = 'Active' + diff.inMinutes.toString() + 'm ago';
      } else if (diff.inMinutes <= 20 && diff.inMinutes >= 10) {
        time = 'Away';
      } else if (diff.inMinutes <= 10) {
        time = 'Online';
      } else if (diff.inSeconds > 0) {
        time = 'Online';
      } else if (diff.inMilliseconds > 0) {
        time = 'Online';
      } else if (diff.inMicroseconds > 0) {
        time = 'Online';
      } else {
        time = 'Online';
      }
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = 'Active' + diff.inDays.toString() + 'd ago';
    } else if (diff.inDays > 6) {
      time = 'Active' + (diff.inDays / 7).floor().toString() + 'w ago';
    } else if (diff.inDays > 29) {
      time = 'Active' + (diff.inDays / 30).floor().toString() + 'm ago';
    } else if (diff.inDays > 365) {
      time = '${date.month}-${date.day}-${date.year}';
    }
    return time;
  }

  // String lastSeen(int timestamp) {
  //   var now = DateTime.now();
  //   var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  //   var diff = now.difference(date);
  //   var time = '';
  //   if(){}

  // }

  static String getdob(String date) {
    if (date == null || date.isEmpty) {
      return '';
    }
    var dt = DateTime.parse(date).toLocal();

    var dat = DateFormat.yMMMd().format(dt);
    return dat;
  }

  int countChatListUsers(myID, AsyncSnapshot<QuerySnapshot> snapshot) {
    int resultInt = snapshot.data.docs.length;
    for (var data in snapshot.data.docs) {
      if (data['userId'] == myID) {
        resultInt--;
      }
    }
    return resultInt;
  }

  static String getUserName({
    String id,
    String name,
  }) {
    String userName = '';
    if (name.length > 15) {
      name = name.substring(0, 6);
    }
    name = name.split(' ')[0];
    id = id.substring(3, 8).toLowerCase();
    userName = '$name$id';
    return userName;
  }

  static bool validateEmal(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    var status = regExp.hasMatch(email);
    return status;
  }

  static customSnackBar(GlobalKey<ScaffoldState> _scaffoldKey, String msg,
      {double height = 30, Color backgroundColor = Colors.black}) {
    if (_scaffoldKey == null || _scaffoldKey.currentState == null) {
      return;
    }
    _scaffoldKey.currentState.hideCurrentSnackBar();
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        msg,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
