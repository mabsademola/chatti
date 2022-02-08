// ignore_for_file: use_key_in_widget_constructors

import 'package:chatti/dialogs/dialog.dart';
import 'package:chatti/helper/utility.dart';
import 'package:chatti/util/loadings.dart';

import 'package:chatti/Widgets/text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
// class _LoginScreenState extends State<LoginScreen> {
  Utility utility = Utility();
  CustomLoader loader = CustomLoader();
  Dialogs dia = Dialogs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            // Spacer(),
            Expanded(
                flex: 2,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      CupertinoIcons.chat_bubble_text_fill,
                      size: 60.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "Chatti",
                      style: TextStyle(
                        fontSize: 60.0,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ))),
            // Spacer(),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Text(
                    "By clicking Log in you agree to the following \n Learn how we process your data in our Privacy Policy and Cookies Policy",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 30.0),
                  MyTextButton(
                    buttonName: 'LOGIN WITH EMAIL',
                    onTap: () {
                      Navigator.of(context).pushNamed('/LoginWithEmail');
                    },
                  ),
                  SizedBox(height: 20.0),
                  MyTextButton(
                    buttonName: 'REGISTER WITH EMAIL',
                    onTap: () {
                      Navigator.of(context).pushNamed('/RegisterWithEmail');

                      // var state =
                      //     Provider.of<AuthProvider>(context, listen: false);
                      // // loader.showLoader(context);
                      // state.googleSignIn().then((status) {
                      //   // // print(status)
                      //   // if (state.user != null) {
                      //   //   loader.hideLoader();
                      //   //   Navigator.pop(context);
                      //   //   loginCallback();
                      //   // } else {
                      //   //   loader.hideLoader();
                      //   //   cprint('Unable to login',
                      //   //       errorIn: '_googleLoginButton');
                      //   // }
                      // });
                    },
                  ),
                  SizedBox(height: 30.0),
                  GestureDetector(
                    onTap: () {
                      dia.troublelogin(
                        context: context,
                      );
                    },
                    child: Text(
                      "Trouble logging in?",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
