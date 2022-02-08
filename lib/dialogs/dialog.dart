// ignore_for_file: prefer_const_constructors

import 'package:chatti/extensions/text_extension.dart';
import 'package:chatti/helper/utility.dart';
import 'package:chatti/provider/auth_provider.dart';
import 'package:chatti/provider/chat_provider.dart';
import 'package:chatti/screens/auth/login_screen.dart';
import 'package:chatti/Widgets/text_fields.dart';
import 'package:chatti/utility.dart/theme.dart';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import '../util/customalert.dart';

class Dialogs {
  Utility utility = Utility();

  showLogoutDialog(BuildContext context) {
    var state = Provider.of<AuthProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => CustomAlert(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 15.0),
              Text(
                "Chatti",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                'Are you sure you want to Logout?',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: 130.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        'No',
                        style: TextStyle(
                            // color: Colors.white,
                            ),
                      ),
                      // onPressed: () => exit(0),
                      onPressed: () => Navigator.pop(context),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Container(
                    height: 40.0,
                    width: 130.0,
                    child: OutlineButton(
                      onPressed: () {
                        state
                            .signOut(
                          context,
                        )
                            .then((value) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary),
                      child: Text(
                        'Yes',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),

                      // color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  showFGDialog(BuildContext context) {
    // var state = Provider.of<AuthProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => CustomAlert(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 15.0),
              Image.asset(
                'lib/assets/gif/success1.gif',
                width: 80,
                color: kPrimaryColor,
              ),
              SizedBox(height: 25.0),
              Text(
                'A reset password link is sent yo your mail.You can reset your password from there',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 40.0),
              MyTextButton(
                buttonName: 'Check Email',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  showCustomDialog({BuildContext context, Widget custom}) {
    var state = Provider.of<AuthProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => CustomAlert(
        child: Padding(padding: EdgeInsets.all(20.0), child: custom),
      ),
    );
  }

  showblock({
    BuildContext context,
    String isname,
    VoidCallback block,
  }) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(
                'Block User',
              ),
              content: Text(
                "Block ${textdo(isname)}? Block contacts will no longer be able to send you messages",
              ),
              actions: [
                TextButton(
                  style: ButtonStyle(),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                  ),
                ),
                TextButton(
                  style: ButtonStyle(),
                  onPressed: block,
                  child: Text(
                    "Block",
                  ),
                ),
              ],
            ));
  }

  clearmsg({
    BuildContext context,
    @required String isname,
    @required Function clearbutton,
  }) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(
                'Delete Chat',
              ),
              content: Text(
                "Are you sure you want to delete the chat with ${textdo(isname)}?",
              ),
              actions: [
                TextButton(
                  style: ButtonStyle(),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                  ),
                ),
                TextButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    print("yessssss");
                    clearbutton;
                  },
                  child: Text(
                    "Delete Chat",
                  ),
                ),
              ],
            ));
  }

  troublelogin({
    BuildContext context,
  }) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(
                'Trouble logging in?',
              ),
              content: Text(
                "1) Make sure your network connection is strong \n 2) Make sure your location is turned on, login or signup might failed whenever your address is null \n 3) Relunch this app with your location and strong connection network",
              ),
              actions: [
                TextButton(
                  style: ButtonStyle(),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                  ),
                ),
                TextButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    utility.feedback();
                  },
                  child: Text(
                    "Send Feedback",
                  ),
                ),
              ],
            ));
  }

  clearnotifi({
    BuildContext context,
    VoidCallback clear,
  }) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Text("Are you sure you want to clear notification "),
              actions: [
                TextButton(
                  style: ButtonStyle(),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'No',
                  ),
                ),
                TextButton(
                  style: ButtonStyle(),
                  onPressed: clear,
                  child: Text(
                    "Yes",
                  ),
                ),
              ],
            ));
  }
}
