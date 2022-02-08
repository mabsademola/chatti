import 'package:chatti/extensions/text_extension.dart';
import 'package:chatti/models/user_model.dart';
import 'package:chatti/provider/auth_provider.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:chatti/Widgets/text_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class LoginWithEmail extends StatefulWidget {
  final VoidCallback loginCallback;

  const LoginWithEmail({Key key, this.loginCallback}) : super(key: key);
  @override
  _LoginWithEmailState createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  bool isPasswordVisible = true;
  TextEditingController emailtextcontroller = TextEditingController();
  TextEditingController passwordtextcontroller = TextEditingController();
  bool isLocationServiceEnabled = false;
  bool passwordVisibility = true;
  var address;
  GeoPoint location;
  UserModel _userModel;
  final _formKey = GlobalKey<FormState>();

  // double latitude = 0;
  // double longitude = 0;
  GeoFirePoint locations;
  // UserModel _userModel;
  final geo = Geoflutterfire();

  void _submitForm() {
    var state = Provider.of<AuthProvider>(context, listen: false);

    UserModel userModel = UserModel(
      lastSeen: DateTime.now().microsecondsSinceEpoch,
    );

    state.loginWithEmailAndPassword(
      emailtextcontroller.text,
      passwordtextcontroller.text,
      context,
      _userModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            width: 24,
            color: Colors.white70,
            image: Svg('assets/images/back_arrow.svg'),
          ),
        ),
      ),
      body: SafeArea(
          child: CustomScrollView(
        reverse: true,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back",
                          style: kHeadline,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Login to your account",
                          style: kBodyText2,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              entry('Email',
                                  inputType: TextInputType.emailAddress,
                                  controller: emailtextcontroller,
                                  validator: (value) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)
                                    ? null
                                    : "Enter a correct email";
                              }),
                              entry(
                                "Password",
                                inputType: TextInputType.visiblePassword,
                                offstage: false,
                                validator: (value) {
                                  return value.isEmpty
                                      ? "Enter a correct password"
                                      : null;
                                },
                                controller: passwordtextcontroller,
                                obscureText: passwordVisibility,
                                onTap: () {
                                  setState(() {
                                    passwordVisibility = !passwordVisibility;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/Forgetpassword');
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    "Forget Password ?",
                                    style: kBodyText.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont't have an account ? ",
                        style: kBodyText,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/RegisterWithEmail');
                        },
                        child: Text(
                          'Register',
                          style: kBodyText.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextButton(
                    buttonName: 'LOGIN',
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        _submitForm();
                        // try {
                        //   isLocationServiceEnabled
                        //       ? _submitForm()
                        //       : Navigator.of(context).pushNamed('/Locationdis');
                        // } catch (e) {
                        //   print(e);

                        //   //TODO error
                        // }
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
