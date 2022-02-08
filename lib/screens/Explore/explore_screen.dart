import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatti/Widgets/shimmers.dart';
import 'package:chatti/extensions/text_extension.dart';
import 'package:chatti/listtile/searchtile.dart';
import 'package:chatti/models/user_model.dart';
import 'package:chatti/screens/Userprofile/pro.dart';
import 'package:chatti/services/database.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:getwidget/getwidget.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  Geoflutterfire geo = Geoflutterfire();
  bool isSearching = false;
  bool clear = false;
  DatabaseMethods db = DatabaseMethods();
  TextEditingController searchUserEditingController = TextEditingController();
  Stream usersStream, searchStream;
  bool byloca = false;

  Stream<List<DocumentSnapshot>> stream;
  FocusNode _focusNode = FocusNode();
  // double radius = 50;
  // var radius = BehaviorSubject.seeded(100.0);

  onSearchClick() async {
    isSearching = true;
    // setState(() {});
    searchStream = await DatabaseMethods()
        .getUserByname(searchUserEditingController.text.toLowerCase());

    setState(() {});
  }

  Widget searchUsersList() {


    return StreamBuilder(
      stream: searchStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
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
                              builder: (context) => ProfileScreen(user: user)));
                    },
                  );
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

  //get nearby users
  getusers() {
    return StreamBuilder(
      stream: usersStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? GridView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 180,
                  // crossAxisSpacing: 2,
                  childAspectRatio: 0.8,
                  // mainAxisSpacing: 2
                ),
                itemBuilder: (BuildContext _context, int index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  UserModel user = UserModel.fromDocument(ds);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                    user: user,
                                    // ds["userId"],

                                    // inCaps(ds["displayName"]),
                                    // ds["userName"],
                                    // ds["profilePic"],
                                    // ds["gender"],
                                    // ds["dob"],
                                    // ds["about"],
                                    // ds["address"],
                                    // ds["location"],
                                    // ds["active"],
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                                bottom: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          if (ds["active"] == "online")
                                            Container(
                                              height: 8,
                                              width: 8,
                                              decoration: BoxDecoration(
                                                color: kOnlineColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          if (ds["active"] == "away")
                                            Container(
                                              height: 8,
                                              width: 8,
                                              decoration: BoxDecoration(
                                                color: kSecondaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          if (ds["active"] == "offline")
                                            Container(
                                              height: 8,
                                              width: 8,
                                              decoration: BoxDecoration(
                                                color: kContentColorDarkTheme,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          if (ds["active"] == null)
                                            Container(
                                              height: 8,
                                              width: 8,
                                              decoration: BoxDecoration(
                                                color: kContentColorDarkTheme,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            inCaps(ds["displayName"]),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        ds["gender"],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 2,
                                offset: Offset(1, 1),
                              ),
                            ],

                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  ds["profilePic"] != null
                                      ? ds["profilePic"]
                                      : maleimg,
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  );

                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => ProfileScreen(
                  //                   user: user,
                  //                   // ds["userId"],

                  //                   // inCaps(ds["displayName"]),
                  //                   // ds["userName"],
                  //                   // ds["profilePic"],
                  //                   // ds["gender"],
                  //                   // ds["dob"],
                  //                   // ds["about"],
                  //                   // ds["address"],
                  //                   // ds["location"],
                  //                   // ds["active"],
                  //                 )));
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(4.0),
                  //     child: Container(
                  //       child: Stack(
                  //         fit: StackFit.expand,
                  //         children: [
                  //           Positioned(
                  //               bottom: 0,
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(8.0),
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     Row(
                  //                       children: [
                  //                         if (ds["active"] == "online")
                  //                           Container(
                  //                             height: 8,
                  //                             width: 8,
                  //                             decoration: BoxDecoration(
                  //                               color: kOnlineColor,
                  //                               shape: BoxShape.circle,
                  //                             ),
                  //                           ),
                  //                         if (ds["active"] == "away")
                  //                           Container(
                  //                             height: 8,
                  //                             width: 8,
                  //                             decoration: BoxDecoration(
                  //                               color: kSecondaryColor,
                  //                               shape: BoxShape.circle,
                  //                             ),
                  //                           ),
                  //                         if (ds["active"] == "offline")
                  //                           Container(
                  //                             height: 8,
                  //                             width: 8,
                  //                             decoration: BoxDecoration(
                  //                               color: kContentColorDarkTheme,
                  //                               shape: BoxShape.circle,
                  //                             ),
                  //                           ),
                  //                         if (ds["active"] == null)
                  //                           Container(
                  //                             height: 8,
                  //                             width: 8,
                  //                             decoration: BoxDecoration(
                  //                               color: kContentColorDarkTheme,
                  //                               shape: BoxShape.circle,
                  //                             ),
                  //                           ),
                  //                         SizedBox(
                  //                           width: 3,
                  //                         ),
                  //                         Text(
                  //                           inCaps(ds["displayName"]),
                  //                           style: TextStyle(
                  //                             fontSize: 12,
                  //                             fontWeight: FontWeight.w600,
                  //                           ),
                  //                         ),
                  //                         SizedBox(
                  //                           height: 20,
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     Text(
                  //                       ds["gender"],
                  //                       style: TextStyle(
                  //                           fontSize: 12,
                  //                           fontWeight: FontWeight.w600),
                  //                     ),
                  //                     SizedBox(
                  //                       height: 10,
                  //                     ),
                  //                   ],
                  //                 ),
                  //               )),
                  //         ],
                  //       ),
                  //       decoration: BoxDecoration(
                  //           boxShadow: <BoxShadow>[
                  //             BoxShadow(
                  //               blurRadius: 2,
                  //               offset: Offset(1, 1),
                  //             ),
                  //           ],

                  //           // color: Colors.white,
                  //           borderRadius: BorderRadius.circular(20),
                  //           image: DecorationImage(
                  //               image: CachedNetworkImageProvider(
                  //                 ds["profilePic"] != null
                  //                     ? ds["profilePic"]
                  //                     : maleimg,
                  //               ),
                  //               fit: BoxFit.cover)),
                  //     ),
                  //   ),
                  // );
                })
            : snapshot.connectionState == ConnectionState.waiting
                ? gridshimmer()
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
                          "Unable to display users.....",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  );
      },
    );
  }

  byreco() async {
    usersStream = await DatabaseMethods().getAllUsers();
    print(usersStream);
  }

  // bylocation() async {
  //   GeoFirePoint center = geo.point(
  //       latitude: await SharedPreferenceHelper().getlat(),
  //       longitude: await SharedPreferenceHelper().getLong());

  //   stream = geo
  //       .collection(
  //           collectionRef: FirebaseFirestore.instance.collection("Users"))
  //       .within(center: center, radius: 50, field: 'location');
  // }

  @override
  void initState() {
    byreco();
    // bylocation();
    _focusNode.unfocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                              hintText: "Search for people",
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                          onTap: () {
                            GFToast.showToast(
                                "This feature is currently disabled", context,
                                toastPosition: GFToastPosition.BOTTOM,
                                textStyle: TextStyle(
                                    fontSize: 13, color: GFColors.DARK),
                                backgroundColor: GFColors.LIGHT,
                                trailing: Icon(
                                  CupertinoIcons.exclamationmark_circle_fill,
                                  color: GFColors.INFO,
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              CupertinoIcons.globe,
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
                          child: InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(32.0),
                            ),
                            onTap: () {
                              GFToast.showToast(
                                  "This feature is currently disabled", context,
                                  toastPosition: GFToastPosition.BOTTOM,
                                  textStyle: TextStyle(
                                      fontSize: 13, color: GFColors.DARK),
                                  backgroundColor: GFColors.LIGHT,
                                  trailing: Icon(
                                    CupertinoIcons.exclamationmark_circle_fill,
                                    color: GFColors.INFO,
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(CupertinoIcons.slider_horizontal_3),
                            ),
                          ),

                          // PopupMenuButton<_choice>(
                          //   elevation: 0,
                          //   color: Colors.transparent,

                          //   onSelected: (choice) {
                          //     if (choice.id == 1) {
                          //       bylocation();
                          //       setState(() {
                          //         byloca = true;
                          //       });
                          //     } else {
                          //       setState(() {
                          //         byloca = false;
                          //       });
                          //     }
                          //   },

                          //   // grey.withOpacity(0.7),

                          //   icon: Icon(CupertinoIcons.slider_horizontal_3),

                          //   itemBuilder: (BuildContext context) {
                          //     return choices.map((_choice choice) {
                          //       return PopupMenuItem<_choice>(
                          //         value: choice,
                          //         child: Container(
                          //           margin: const EdgeInsets.only(top: 10.0),
                          //           decoration: BoxDecoration(
                          //             color: Colors.grey.withOpacity(0.7),
                          //             borderRadius: BorderRadius.circular(50),
                          //           ),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(10.0),
                          //             child: Row(
                          //               children: [
                          //                 Icon(choice.icon),
                          //                 SizedBox(
                          //                   width: 20,
                          //                 ),
                          //                 Text(
                          //                   choice.title,
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       );
                          //     }).toList();
                          //   },
                          // ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(1)),
      ),
      body: isSearching ? searchUsersList() : getusers(),
    );
  }
}

// ignore_for_file: camel_case_types, unnecessary_const

class _choice {
  const _choice({this.title, this.icon, this.id});

  final IconData icon;
  final String title;
  final int id;
}

const List<_choice> choices = const <_choice>[
  const _choice(
    title: 'Based On Location',
    icon: CupertinoIcons.placemark,
    id: 1,
  ),
  const _choice(
    title: 'Based On Recommedation',
    icon: CupertinoIcons.rectangle_grid_2x2,
    id: 2,
  ),
];
