import 'package:chatti/helper/utility.dart';
import 'package:chatti/models/personal_model.dart';
import 'package:chatti/models/user_model.dart';
import 'package:chatti/provider/getdata_provider.dart';
import 'package:chatti/provider/nav_provider.dart';
import 'package:chatti/screens/EditProfile/edit_profile.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chatti/utility.dart/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

import 'package:provider/provider.dart';

import 'components/circular_image.dart';
import 'components/headerWidget.dart';

import 'components/settingsRowWidget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen(
    NavProvider personal, {
    Key key,
    @required this.personalmodel,
  }) : super(key: key);

  final PersonalModel personalmodel;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel usermodel;
  Utility utility = Utility();

  @override
  void initState() {
    // getmsgcount();
    // Provider.of<ProfileProvider>(context, listen: false);
    // // print(profile.displayName);
    // var location = Provider.of<LocationProvider>(context, listen: false);
    // location.getCurrentPosition(context: context, auto: true);
    usermodel = Provider.of<GetDataProvider>(context, listen: false).usermodel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var data = Provider.of<GetDataProvider>(context, listen: false).usermodel;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CircularImage(
                        path: usermodel.profilePic,
                        height: 50,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            usermodel.displayName,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10),
                          Opacity(
                            opacity: 0.64,
                            child: Text(
                              usermodel.userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.64,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditProfilePage()));
                      },
                      child: Icon(
                        Icons.chevron_right,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(20)),
      ),
      body: ListView(
        children: <Widget>[
          HeaderWidget(
            'About',
          ),
          // // SizedBox(
          // //   height: 20,
          // // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 120,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: SingleChildScrollView(
                child: Text(
                  usermodel.about,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),

          HeaderWidget(
            'Settings',
          ),

          SettingRowWidget(
            "General",
            icon: CupertinoIcons.gear,
            // navigateTo: 'DisplayAndSoundPage'
            onPressed: () {
              GFToast.showToast("This feature is currently disabled", context,
                  toastPosition: GFToastPosition.BOTTOM,
                  textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
                  backgroundColor: GFColors.LIGHT,
                  trailing: Icon(
                    CupertinoIcons.exclamationmark_circle_fill,
                    color: GFColors.INFO,
                  ));
            },
          ),

          SettingRowWidget("Notifications", icon: CupertinoIcons.bell,
              // navigateTo: 'DisplayAndSoundPage',
              onPressed: () {
            GFToast.showToast("This feature is currently disabled", context,
                toastPosition: GFToastPosition.BOTTOM,
                textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
                backgroundColor: GFColors.LIGHT,
                trailing: Icon(
                  CupertinoIcons.exclamationmark_circle_fill,
                  color: GFColors.INFO,
                ));
          }),

          SettingRowWidget("Language", icon: CupertinoIcons.globe,
              // navigateTo: "AboutPage", lan: true
              onPressed: () {
            GFToast.showToast("This feature is currently disabled", context,
                toastPosition: GFToastPosition.BOTTOM,
                textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
                backgroundColor: GFColors.LIGHT,
                trailing: Icon(
                  CupertinoIcons.exclamationmark_circle_fill,
                  color: GFColors.INFO,
                ));
          }),

          SettingRowWidget(
            "FeedBack",
            icon: CupertinoIcons.captions_bubble,
            onPressed: () {
              utility.feedback();
            },
          ),

          SettingRowWidget(
            "Privacy and Policy",
            icon: CupertinoIcons.doc_text,
            onPressed: () {
              utility.launchpolicy();
            },
          ),

          SettingRowWidget("About Chatti",
              icon: CupertinoIcons.chat_bubble_text, navigateTo: 'AppInfo'),
          // Container(
          //   child: Row(
          //     children: [
          //       Container(
          //           decoration: BoxDecoration(
          //             color: kPrimaryColor.withOpacity(0.1),
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           padding: const EdgeInsets.all(10),
          //           child: Icon(
          //             CupertinoIcons.square_arrow_right,
          //             color: kPrimaryColor,
          //           )),
          //       Text("Sign Out",
          //           style:
          //               TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // Container(
          //   height: 70,
          //   width: 100,
          //   padding: const EdgeInsets.all(10),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     color: Colors.grey.withOpacity(0.4),
          //   ),
          //   child: Row(
          //     children: [
          //       Icon(Icons.exit_to_app),
          //       Text(
          //         "Sign Out",
          //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
