// ignore_for_file: prefer_const_constructors

import 'package:chatti/Widgets/shimmers.dart';
import 'package:chatti/dialogs/dialog.dart';

import 'package:chatti/models/notification_model.dart';

import 'package:chatti/services/database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Component/notifitiles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Stream notificationsStream;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final notifications = FirebaseFirestore.instance.collection('Notifications');
  // DatabaseMethods db = DatabaseMethods();
  // notifiget() async {
  //   await DatabaseMethods(uid: auth.currentUser.uid)
  //       .updateUserNotifi(read: true);
  // }

  getNotifications() async {
    notificationsStream =
        await DatabaseMethods(uid: auth.currentUser.uid).getAllNotifications();

    setState(() {});
  }

  notificationsList() {
    return StreamBuilder(
      stream: notificationsStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  NotifiModel notifi = NotifiModel.fromDocument(ds);

                  return notifi != null
                      ? Shownotification(notifi: notifi)
                      : SingleNotificationShimmer();
                })
            : snapshot.connectionState == ConnectionState.waiting
                ? NotificationShimmer()
                : snapshot.hasError
                    ? Center(
                        child: Text(
                          "Unable to get Notifications",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      )
                    : Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff191720).withOpacity(0.5),
                          ),
                          height: 200,
                          width: 200,
                          child: Center(
                            child: Text(
                              "No Notification yet.....",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      );
      },
    );
  }

  @override
  void initState() {
    getNotifications();
    // notifiget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Notifications",
          style: TextStyle(
            fontSize: 40.0,
            // letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
            //    color: Colors.white
          ),
        ),
        actions: [
          IconButton(
              tooltip: "Clear Notfications",
              icon: const Icon(
                CupertinoIcons.archivebox_fill,
              ),
              onPressed: () {
                Dialogs().clearnotifi(
                    context: context,
                    clear: () async {
                      setState(() {});
                      Navigator.of(context);
                      {
                        await notifications.doc(auth.currentUser.uid).delete();
                      }
                    });
              }),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: notificationsList(),
    );
  }
}
