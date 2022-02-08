// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:chatti/Widgets/shimmers.dart';
import 'package:chatti/extensions/text_extension.dart';
import 'package:chatti/helper/database.dart';

import 'package:chatti/listtile/searchtile.dart';
import 'package:chatti/models/listchat.dart';
import 'package:chatti/models/user_model.dart';
import 'package:chatti/provider/getdata_provider.dart';
import 'package:chatti/screens/Messages/message_screen.dart';

import 'package:chatti/dialogs/dialog.dart';
import 'package:chatti/util/loadings.dart';
import 'package:chatti/util/story_item.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:draggable_fab/draggable_fab.dart';

import 'package:chatti/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import 'Component/listiles.dart';

class ListchatScreen extends StatefulWidget {
  ListchatScreen();
  @override
  _ListchatScreenState createState() => _ListchatScreenState();
}

class _ListchatScreenState extends State<ListchatScreen> {
  // ds ds;
  bool isSearching = false;
  bool clear = false;
  QuerySnapshot searchSnapshot;
  TextEditingController searchUserEditingController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseMethods db = DatabaseMethods();
  UserModel usermodel;

  CustomLoader loader = CustomLoader();
  Stream usersStream, chatRoomsStream, chatRoomsStreamm;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      switch (state) {
        case AppLifecycleState.resumed:
          print("resume");
          DatabaseMethods(uid: auth.currentUser.uid).updateActive(
              active: "online",
              lastSeen: DateTime.now().millisecondsSinceEpoch);
          // getDelivery();

          break;
        case AppLifecycleState.inactive:
          print("inactive");
          DatabaseMethods(uid: auth.currentUser.uid).updateActive(
              active: "away", lastSeen: DateTime.now().millisecondsSinceEpoch);

          break;
        case AppLifecycleState.paused:
          print("paused");
          DatabaseMethods(uid: auth.currentUser.uid).updateActive(
              active: "offline",
              lastSeen: DateTime.now().millisecondsSinceEpoch);

          break;
        case AppLifecycleState.detached:
          print("detached");
          DatabaseMethods(uid: auth.currentUser.uid).updateActive(
              active: "offline",
              lastSeen: DateTime.now().millisecondsSinceEpoch);

          break;
      }
    });
  }

  getChatRooms() async {
    chatRoomsStream =
        await DatabaseMethods(uid: auth.currentUser.uid).getchatlists();
    // usersStream = await DatabaseMethods().getAllUsers();

    setState(() {});
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  ListChatModel user = ListChatModel.fromDocument(ds);

                  return user != null ? Details(ds: user) : SingleListshimmer();
                })
            : snapshot.connectionState == ConnectionState.waiting
                ? Listshimmer()
                : snapshot.hasError
                    ? Center(
                        child: Text(
                          "Unable to get Messages",
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
                              "No Message yet.....",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      );
      },
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 4, left: 4, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      // CircularImage(path: usermodel.profilePic, height: 55),
                      Container(
                        width: 55,
                        height: 55,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(usermodel.profilePic),
                                      fit: BoxFit.cover)),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 19,
                                  height: 19,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: white),
                                  child: Icon(
                                    Icons.add_circle,
                                    color: kPrimaryColor,
                                    size: 19,
                                  ),
                                ))
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 70,
                        child: Text(
                          usermodel.displayName,
                          overflow: TextOverflow.ellipsis,
                          // style: TextStyle(color: white),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                    children: List.generate(stories.length, (index) {
                  return StoryItem(
                    img: stories[index]['img'],
                    name: stories[index]['name'],
                  );
                })),
              ],
            ),
          ),
          Flexible(child: chatRoomsList())
        ],
      ),
    );
  }

  onSearchClick() async {
    isSearching = true;
    setState(() {});
    usersStream =
        await DatabaseMethods().getUserByname(searchUserEditingController.text);

    setState(() {});
  }

  Widget searchUsersList() {
    // var authstate = Provider.of<ProfileProvider>(context);

    return StreamBuilder(
      stream: usersStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                // physics: ScrollableScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  UserModel user = UserModel.fromDocument(ds);
                  return UserTile(
                      profileUrl: ds["profilePic"],
                      name: inCaps(ds["displayName"]),
                      userName: ds["userName"],
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MessagesScreen(
                                      user: user,
                                    )));
                      });
                },
              )
            : snapshot.connectionState == ConnectionState.waiting
                ? Listshimmer()
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
                          "No results found for ${searchUserEditingController.text.toUpperCase()}",
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
    usermodel = Provider.of<GetDataProvider>(context, listen: false).usermodel;
    getChatRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Chats",
          style: TextStyle(
            fontSize: 40.0,
            // letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
            //    color: Colors.white
          ),
        ),
        actions: [
          IconButton(
            tooltip: "Add to story",
            icon: FaIcon(
              CupertinoIcons.camera,
            ),
            onPressed: () {
              // Navigator.of(context).pushNamed('/CameraApp');

              // loader.showLoader(
              //   context,
              // );

              GFToast.showToast("This feature is currently disabled", context,
                  toastPosition: GFToastPosition.BOTTOM,
                  textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
                  backgroundColor: GFColors.LIGHT,
                  trailing: Icon(
                    CupertinoIcons.exclamationmark_circle_fill,
                    color: GFColors.INFO,
                  ));

              // getChatRooms();
            },
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            onPressed: () {
              Dialogs().showLogoutDialog(context);
            },
          ),
        ],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isSearching
                      ? GestureDetector(
                          onTap: () {
                            isSearching = false;
                            searchUserEditingController.text = "";

                            clear = false;
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.arrow_back,
                              size: 26,
                            ),
                          ),
                        )
                      : Container(),
                  Expanded(
                    child: Container(
                      height: 35,
                      margin: EdgeInsets.only(right: 10, left: 10),
                      // padding: EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            autofocus: false,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (v) {
                              if (v != "") {
                                onSearchClick();
                              }
                            },
                            onChanged: (val) {
                              clear = true;
                              if (val != "") {
                                onSearchClick();
                              }
                              setState(() {});
                            },
                            controller: searchUserEditingController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintText: "Search for chats & people",
                            ),
                          )),
                          clear
                              ? GestureDetector(
                                  onTap: () {
                                    searchUserEditingController.text = "";
                                    clear = false;
                                    setState(() {});
                                  },
                                  child: Icon(Icons.close))
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(50)),
      ),
      floatingActionButton: Align(
        alignment: Alignment.centerRight,
        heightFactor: 4.0,
        child: DraggableFab(
          // initPosition: Offset(0, 20),
          child: FloatingActionButton(
            tooltip: "View Contacts",
            onPressed: () {
              Navigator.of(context).pushNamed('/ContactList');
            },
            child: Icon(
              CupertinoIcons.chat_bubble_text_fill,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: isSearching ? searchUsersList() : chatRoomsList(),
      // body: isSearching ? searchUsersList() : getBody(),
    );
  }
}
