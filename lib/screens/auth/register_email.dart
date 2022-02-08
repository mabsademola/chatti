// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:chatti/dialogs/picker.dart';
import 'package:chatti/extensions/text_extension.dart';
import 'package:chatti/helper/age_calculator.dart';
import 'package:chatti/helper/ageformat.dart';

import 'package:chatti/models/user_model.dart';
import 'package:chatti/provider/auth_provider.dart';
import 'package:chatti/provider/location_provider.dart';

import 'package:chatti/utility.dart/theme.dart';
import 'package:chatti/util/loadings.dart';
import 'package:chatti/Widgets/text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

class RegisterWithEmail extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterWithEmail> {
  bool passwordVisibility = true;

  TextEditingController emailtextcontroller = TextEditingController();
  TextEditingController nametextcontroller = TextEditingController();
  TextEditingController agetextcontroller = TextEditingController();
  TextEditingController passwordtextcontroller = TextEditingController();
  // bool isLocationServiceEnabled = false;
  final _formKey = GlobalKey<FormState>();
  // final FirebaseAuth auth = FirebaseAuth.instance;
  CustomLoader loader = CustomLoader();
  // final geo = Geoflutterfire();
  UserModel _userModel;
  String dropdownValue = 'Choose Gender';
  String date = 'Date of birth';
  DateTime dateTime = DateTime.now();

  Widget buildDatePicker() => SizedBox(
        height: 210,
        child: CupertinoDatePicker(
          backgroundColor: Colors.white,
          minimumYear: 1921,
          maximumYear: DateTime.now().year,
          initialDateTime: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );

  void _submitForm() {
    loader.showLoader(
      context,
    );
    var state = Provider.of<AuthProvider>(context, listen: false);
    var locate = Provider.of<LocationProvider>(context, listen: false);

    var location = locate.usermodel;

    if (location.address != null && location.location != null) {
      UserModel userModel = UserModel(
        email: emailtextcontroller.text.toLowerCase(),
        lastSeen: DateTime.now().microsecondsSinceEpoch,
        address: location.address,
        location: location.location,
        displayName: nametextcontroller.text.toLowerCase(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        dob: getFormatedDate(dateTime),
        gender: dropdownValue,
        profilePic: dropdownValue == "Female" ? femaleimg : maleimg,
        // isVerified: false,
      );
      _userModel = userModel;

      state.registerWithEmailAndPassword(
        _userModel,
        passwordtextcontroller.text,
        context,
      );
    } else {
      locate
          .getCurrentPosition(context: context)
          .whenComplete(() => _submitForm());
      GFToast.showToast(
          "Unable to get location,this might cause problem during signing up",
          context,
          toastPosition: GFToastPosition.BOTTOM,
          textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
          backgroundColor: GFColors.LIGHT,
          trailing: Icon(
            CupertinoIcons.exclamationmark_circle_fill,
            color: kPrimaryColor,
          ));
    }
  }

  @override
  void initState() {
    var location = Provider.of<LocationProvider>(context, listen: false);
    location.getCurrentPosition(context: context);

    super.initState();
  }

  @override
  void dispose() {
    emailtextcontroller.dispose();
    nametextcontroller.dispose();
    passwordtextcontroller.dispose();
    // _dob.dispose();
    super.dispose();
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Register",
                    style: kHeadline,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create new account to get started.",
                    style: kBodyText2,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    entry('Display Name',
                        inputType: TextInputType.name,
                        controller: nametextcontroller, validator: (value) {
                      return value.length < 3
                          ? "Display Name must not be less than 3 Characters"
                          : null;
                    }),
                    entry('Email',
                        inputType: TextInputType.emailAddress,
                        controller: emailtextcontroller, validator: (value) {
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
                        return value.length < 6
                            ? "Password must not be less than 6 Characters"
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      // width: MediaQuery.of(context).size.width,
                      // margin: EdgeInsets.all(20),
                      child: DropdownButtonHideUnderline(
                        child: GFDropdown(
                          // hint: "Choose Gender",
                          border: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          dropdownButtonColor: Colors.transparent,
                          padding: const EdgeInsets.all(15),
                          borderRadius: BorderRadius.circular(10),
                          // border:
                          //     const BorderSide(color: Colors.black12, width: 1),
                          // dropdownColor: Colors.grey[300],
                          value: dropdownValue,
                          onChanged: (dynamic newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: ['Choose Gender', 'Male', 'Female']
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(children: [
                        Expanded(
                            child: TextField(
                          controller: agetextcontroller,
                          enabled: false,
                          decoration: InputDecoration.collapsed(hintText: date),
                          // date
                        )),
                        IconButton(
                          tooltip: "Choose Date of Birth",
                          onPressed: () {
                            Picker.showSheet(
                              context,
                              child: buildDatePicker(),
                              onpress: () {
                                // date =
                                //     DateFormat('dd/MM/yyyy').format(dateTime);
                                final date = dateTime.toString();
                                // final date = DateFormat('dd/MM/yyyy')
                                //     .format(dateTime)
                                //     .toString();
                                Navigator.pop(context);

                                setState(() {
                                  agetextcontroller.text =
                                      getFormatedDate(date);
                                });
                              },
                              // onpress: () {
                              //   date =
                              //       DateFormat('dd/MM/yyyy').format(dateTime);
                              //   setState(() {});

                              //   Navigator.pop(context);
                              // },
                            );
                          },
                          icon: Icon(CupertinoIcons.calendar),
                        ),
                      ]),
                    ),
                  ))
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: kBodyText,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/LoginWithEmail');
                    },
                    child: Text(
                      "Sign In ",
                      style: kBodyText.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              MyTextButton(
                buttonName: 'REGISTER',
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    if (dropdownValue == "Choose Gender") {
                      GFToast.showToast("Please choose your gender", context,
                          toastPosition: GFToastPosition.BOTTOM,
                          textStyle:
                              TextStyle(fontSize: 13, color: GFColors.DARK),
                          backgroundColor: GFColors.LIGHT,
                          trailing: Icon(
                            CupertinoIcons.exclamationmark_triangle_fill,
                            color: kPrimaryColor,
                          ));
                    } else if (agetextcontroller.text.isEmpty) {
                      GFToast.showToast(
                          "Please choose your date of birth", context,
                          toastPosition: GFToastPosition.BOTTOM,
                          textStyle:
                              TextStyle(fontSize: 13, color: GFColors.DARK),
                          backgroundColor: GFColors.LIGHT,
                          trailing: Icon(
                            CupertinoIcons.exclamationmark_triangle_fill,
                            color: kPrimaryColor,
                          ));
                    } else if (AgeCalculator.age(dateTime,
                                today: DateTime.now())
                            .years <
                        10) {
                      GFToast.showToast(
                          "Sorry, you're too young to use this app", context,
                          toastPosition: GFToastPosition.BOTTOM,
                          textStyle:
                              TextStyle(fontSize: 13, color: GFColors.DARK),
                          backgroundColor: GFColors.LIGHT,
                          trailing: Icon(
                            CupertinoIcons.exclamationmark_triangle_fill,
                            color: kPrimaryColor,
                          ));
                    } else {
                      print("2 e dey worl");
                      _submitForm();
                    }

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
    );
  }
}
