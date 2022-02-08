import 'package:chatti/helper/sharedpref_helper.dart';
import 'package:chatti/models/personal_model.dart';

import 'package:chatti/provider/location_provider.dart';
import 'package:chatti/provider/nav_provider.dart';

import 'package:chatti/services/database.dart';

import 'package:chatti/utility.dart/theme.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

import 'package:provider/provider.dart';

import 'ListChats/listchats_screen.dart';

import 'Notification/notification_screen.dart';
import 'Profile/profile_screen.dart';
import 'screens.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> with WidgetsBindingObserver {
  PersonalModel personalModel;
  // DatabaseMethods db = DatabaseMethods(uid: auth.currentUser.uid);
  final FirebaseAuth auth = FirebaseAuth.instance;
  int _currentIndex = 0;
  int unReadMSGCount = 0;
  int chatcount = 0;
  String address;

  getmsgcount() async {
    unReadMSGCount =
        await DatabaseMethods.instanace.getUnreadMSGCount(auth.currentUser.uid);
    setState(() {});
  }

  // getdata() async {
  //   // await DatabaseMethods(uid: auth.currentUser.uid).userData;
  //   // print(personalModel.displayName + "am a boy");

  //   DocumentSnapshot d = await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(auth.currentUser.uid)
  //       .get();
  //   PersonalModel _personalModel = PersonalModel(
  //     userId: d['userId'] ?? await SharedPreferenceHelper().getUserId(),
  //     email: d['email'] ?? await SharedPreferenceHelper().getUserEmail(),
  //     displayName:
  //         d['displayName'] ?? await SharedPreferenceHelper().getdisplayName(),
  //     userName: d['userName'],
  //     profilePic:
  //         d['profilePic'] ?? await SharedPreferenceHelper().getprofilePic(),
  //     gender: d['gender'] ?? await SharedPreferenceHelper().getGender(),
  //     dob: d['dob'] ?? await SharedPreferenceHelper().getDob(),
  //     about: d['about'] ?? await SharedPreferenceHelper().getAbout(),
  //     address: d['address'],
  //     isVerified: d['profilePic'],
  //   );

  //   personalModel = _personalModel;
  //   print(d['userName']);
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      switch (state) {
        case AppLifecycleState.resumed:
          DatabaseMethods(uid: auth.currentUser.uid).updateActive(
              active: "online",
              lastSeen: DateTime.now().millisecondsSinceEpoch);
          GFToast.showToast("RESUME", context,
              toastPosition: GFToastPosition.BOTTOM,
              textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
              backgroundColor: GFColors.LIGHT,
              trailing: Icon(
                CupertinoIcons.exclamationmark_circle_fill,
                color: GFColors.INFO,
              ));
          // getDelivery();
          // _showInterstitialAd();
          break;
        case AppLifecycleState.inactive:
          DatabaseMethods(uid: auth.currentUser.uid).updateActive(
              active: "away", lastSeen: DateTime.now().millisecondsSinceEpoch);
          GFToast.showToast("This feature is currently disabled", context,
              toastPosition: GFToastPosition.BOTTOM,
              textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
              backgroundColor: GFColors.LIGHT,
              trailing: Icon(
                CupertinoIcons.exclamationmark_circle_fill,
                color: GFColors.INFO,
              ));

          break;
        case AppLifecycleState.paused:
          DatabaseMethods(uid: auth.currentUser.uid).updateActive(
              active: "offline",
              lastSeen: DateTime.now().millisecondsSinceEpoch);

          break;
        case AppLifecycleState.detached:
          DatabaseMethods(uid: auth.currentUser.uid).updateActive(
              active: "offline",
              lastSeen: DateTime.now().millisecondsSinceEpoch);

          break;
      }
    });
  }

  Widget _buildNavIcon(IconData icon, {int badge = 0}) {
    return Stack(
      // overflow: Overflow.visible,
      children: [
        Icon(
          icon,
          // size: 22,
        ),
        badge == 0
            ? Positioned(
                right: -5,
                top: -5,
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 9,
                      child: Text(
                        badge == null
                            ? ""
                            : badge != 0
                                ? badge.toString()
                                : "",
                        style: TextStyle(fontSize: 6),
                      ),
                      backgroundColor:
                          badge == 0 ? Colors.transparent : kPrimaryColor,
                      foregroundColor: Colors.white,
                    )),

                //  Container(
                //   height: 24,
                //   width: 24,
                //   constraints: BoxConstraints(
                //     maxHeight: 45,
                //     maxWidth: 45,
                //   ),
                //   decoration: BoxDecoration(
                //     color: Colors.yellowAccent,
                //     shape: BoxShape.circle,
                //   ),
                //   child: Padding(
                //       padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                //       child: CircleAvatar(
                //         radius: 9,
                //         child: Text(
                //           badge == null
                //               ? ""
                //               : badge != 0
                //                   ? badge.toString()
                //                   : "",
                //           style: TextStyle(fontSize: 10),
                //         ),
                //         backgroundColor:
                //             badge == 0 ? Colors.transparent : kPrimaryColor,
                //         foregroundColor: Colors.white,
                //       )),

                //   //  Center(
                //   //   child: Text(
                //   //     "$badge",
                //   //     style: TextStyle(fontSize: 10),
                //   //   ),
                //   // ),
                // ),
              )
            : Container()
      ],
    );
  }

  Widget getBody(NavProvider personal) {
    List<Widget> screens = [
      ListchatScreen(),
      ExploreScreen(),
      NotificationScreen(),
      ProfileScreen(personal)
    ];
    return IndexedStack(
      index: _currentIndex,
      children: screens,
    );
  }

  // Widget friendsList() {
  //   return StreamBuilder(
  //       stream: contactStream,
  //       builder: (context, AsyncSnapshot snapshot) {
  //         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //            setState(() {
  //                     chatcount = snapshot.data.docs.length;
  //                     print("$chatcount");
  //                   });
  //         });
  //       });
  // }

  @override
  void initState() {
    getmsgcount();
    NavProvider data = Provider.of<NavProvider>(context, listen: false);
    data.getdata();
    LocationProvider location =
        Provider.of<LocationProvider>(context, listen: false);
    location.getCurrentPosition(context: context, auto: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NavProvider personal = Provider.of<NavProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Scaffold(body: getBody(personal)),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 12),
            child: Align(
              alignment: Alignment(0.0, 1.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: BottomNavigationBar(
                    elevation: 10,
                    backgroundColor: Color(0xff191720).withOpacity(0.7),
                    type: BottomNavigationBarType.fixed,
                    currentIndex: _currentIndex,
                    items: [
                      BottomNavigationBarItem(
                        icon: _buildNavIcon(CupertinoIcons.chat_bubble_text,
                            badge: unReadMSGCount),
                        // FaIcon(CupertinoIcons.chat_bubble_text),
                        label: "Chats",
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(CupertinoIcons.compass),
                        label: "Explore",
                      ),
                      BottomNavigationBarItem(
                        icon:
                            _buildNavIcon(CupertinoIcons.app_badge, badge: 29),
                        // FaIcon(CupertinoIcons.app_badge),
                        label: "Notifications",
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(CupertinoIcons.person),
                        label: "Profile",
                      ),
                    ],
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
