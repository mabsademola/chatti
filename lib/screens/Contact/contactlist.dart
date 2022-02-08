// ignore_for_file: prefer_const_constructors

import 'package:chatti/Widgets/shimmers.dart';

import 'package:chatti/models/contact_model.dart';

import 'package:chatti/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:getwidget/getwidget.dart';

import 'Component/contactdetails.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key key}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseMethods db = DatabaseMethods();
  int friendcount = 0;
  Stream contactStream;

  getcontacts() async {
    contactStream =
        await DatabaseMethods(uid: auth.currentUser.uid).getfriendlists();
    setState(() {});
  }

 

  Widget friendsList() {
    return StreamBuilder(
      stream: contactStream,
      builder: (context, AsyncSnapshot snapshot) {
        // snapshot.data.docs != null
        //     ? WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //         setState(() {
        //           friendcount = snapshot.data.docs.length;
        //           print("$friendcount");
        //         });
        //       })
        //     : null;
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    setState(() {
                      friendcount = snapshot.data.docs.length;
                      print("$friendcount");
                    });
                  });
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  ContactModel user = ContactModel.fromDocument(ds);

                  return user != null
                      ? ContactDetails(ds: user)
                      : SingleListshimmer();
                })
          
          
          
            : snapshot.connectionState == ConnectionState.waiting
                ? Listshimmer()
                : snapshot.hasError
                    ? Center(
                        child: Text(
                          "Unable to get Contacts",
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
                              "No Contact yet.....",
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
    getcontacts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Contact",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            Text(
              "$friendcount Contact(s)",
              style: TextStyle(
                fontSize: 15,
              ),
            )
          ],
        ),
        actions: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(32.0),
              ),
              onTap: () {
                GFToast.showToast("This feature is currently disabled", context,
                    toastPosition: GFToastPosition.BOTTOM,
                    textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
                    backgroundColor: GFColors.LIGHT,
                    trailing: Icon(
                      CupertinoIcons.exclamationmark_circle_fill,
                      color: GFColors.INFO,
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  CupertinoIcons.search,
                  // size: 30,
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(32.0),
              ),
              onTap: () {
                GFToast.showToast("This feature is currently disabled", context,
                    toastPosition: GFToastPosition.BOTTOM,
                    textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
                    backgroundColor: GFColors.LIGHT,
                    trailing: Icon(
                      CupertinoIcons.exclamationmark_circle_fill,
                      color: GFColors.INFO,
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.more_vert,
                  // size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: friendsList()),
    );
  }
}
