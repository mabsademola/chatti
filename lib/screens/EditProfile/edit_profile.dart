import 'dart:io';

import 'package:chatti/extensions/title_text.dart';

import 'package:chatti/helper/utility.dart';
import 'package:chatti/models/user_model.dart';
import 'package:chatti/provider/auth_provider.dart';
import 'package:chatti/provider/getdata_provider.dart';
import 'package:chatti/screens/Profile/components/circular_image.dart';
import 'package:chatti/services/database.dart';

import 'package:chatti/util/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File _image;

  // String displayName, profilePic, username, userEmail;
  UserModel usermodel;
  bool showPassword = false;
  DatabaseMethods db = DatabaseMethods();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController displayName,
      profilePic,
      address,
      username,
      email,
      about,
      gender,
      _dob;

  String dob;
  void openBottomSheet(
    BuildContext context,
    double height,
    Widget child,
  ) async {
    await showModalBottomSheet(
      // backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: height,
          decoration: BoxDecoration(
            // color: TwitterColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: child,
        );
      },
    );
  }

  getdata() {
    //   usermodel = db.userdata();
    //   displayName.text = usermodel.displayName;
    //   // profilePic.text = usermodel.profilePic;
    //   // username.text = usermodel.userName;
    //   // email.text = usermodel.email;
    //   // about.text = usermodel.about;
    //   // gender.text = usermodel.gender;
    //   // address.text = usermodel.address;

    //   // _dob.text = usermodel.dob;
  }

  Widget _row({String text, Function tap}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      child: ListTile(
        // onTap:tap,
        title: TitleText(text),
        // controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  void openImagePicker(BuildContext context, Function(File) onImageSelected) {
    openBottomSheet(
      context,
      250,
      Column(
        children: <Widget>[
          SizedBox(height: 5),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Color.fromRGBO(101, 118, 133, 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TitleText('Upload Photo'),
          ),
          Divider(height: 0),
          InkWell(
            onTap: () {
              getImage(context, ImageSource.camera, onImageSelected);
            },
            child: _row(
              text: "Camera",
            ),
          ),
          Divider(height: 0),
          InkWell(
            onTap: () {
              getImage(context, ImageSource.gallery, onImageSelected);
            },
            child: _row(
              text: "Existing photo",
            ),
          ),
          Divider(height: 0),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: _row(
              text: "Cancel",
            ),
          ),
        ],
      ),
    );
  }

  void _submitButton() {
    if (displayName.text.length > 20) {
      Utility.customSnackBar(
          _scaffoldKey, 'Name length cannot exceed 20 character');
      return;
    }
    var state = Provider.of<GetDataProvider>(context, listen: false);
    var statee = Provider.of<AuthProvider>(context, listen: false);
    var model = state.usermodel.copyWith(
      email: state.usermodel.email,
      about: state.usermodel.about,
      gender: state.usermodel.gender,
      displayName: state.usermodel.displayName,
      // dob: state.usermodel.dob,
      profilePic: state.usermodel.profilePic,
      // userId: state.userModel.userId,
      userName: state.usermodel.userName,
    );
    if (displayName.text != null && displayName.text.isNotEmpty) {
      model.displayName = displayName.text;
    }
    if (about.text != null && about.text.isNotEmpty) {
      model.about = about.text;
    }
    if (gender.text != null && gender.text.isNotEmpty) {
      model.gender = gender.text;
    }
    // if (dob != null) {
    //   model.dob = dob;
    // }

    statee.updateUserProfile(model, image: _image).then((value) {
      state.getMyInfoFromSharedPreference();
    });
    Navigator.of(context).pop();
  }

  Widget _entrry(String title,
      {TextEditingController controller,
      int maxLine = 1,
      bool isenable = true}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Opacity(
            opacity: 0.8,
            child: customText(
              title,
              style: TextStyle(fontSize: 17),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 5),
          TextField(
            enabled: isenable,
            controller: controller,
            maxLines: maxLine,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            ),
          )
        ],
      ),
    );
  }

  void uploadImage() {
    openImagePicker(context, (file) {
      setState(() {
        _image = file;
      });
    });
  }

  void showCalender() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2019, DateTime.now().month, DateTime.now().day),
      firstDate: DateTime(1950, DateTime.now().month, DateTime.now().day + 3),
      lastDate: DateTime.now().add(Duration(days: 7)),
    );
    setState(() {
      if (picked != null) {
        dob = picked.toString();
        _dob.text = Utility.getdob(dob);
      }
    });
  }

  getImage(BuildContext context, ImageSource source,
      Function(File) onImageSelected) {
    ImagePicker()
        .pickImage(source: source, imageQuality: 50)
        .then((XFile file) {
      onImageSelected(File(file.path));
      Navigator.pop(context);
    });
  }

  Widget _entry(
    String title, {
    String hinttext,
    TextEditingController controller,
    int maxLine = 1,
    bool isenable = true,
    bool iseditable = true,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: Column(
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Opacity(
                opacity: 0.8,
                child: customText(
                  title,
                  style: TextStyle(fontSize: 17),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 50),
              Expanded(
                child: Opacity(
                  opacity: iseditable ? 1 : 0.44,
                  child: TextField(
                      textAlign: TextAlign.end,
                      enabled: isenable ? true : false,
                      controller: controller,
                      style: TextStyle(fontSize: 17),
                      maxLines: maxLine,
                      decoration:
                          InputDecoration.collapsed(hintText: hinttext)),
                ),
              ),
            ],
          ),
          Divider(height: 2)
        ],
      ),
    );
  }

  Widget _userImage() {
    var data = Provider.of<GetDataProvider>(context, listen: false).usermodel;
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0),
        height: 130,
        width: 130,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          shape: BoxShape.circle,
          image: DecorationImage(
              image: customAdvanceNetworkImage(data.profilePic),
              fit: BoxFit.cover),
        ),
        child: CircleAvatar(
          radius: 70,
          backgroundImage: _image != null
              ? FileImage(_image)
              : customAdvanceNetworkImage(data.profilePic),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black38,
            ),
            child: Center(
              child: IconButton(
                onPressed: uploadImage,
                icon: Icon(Icons.camera_alt, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    getdata();
    // getMyInfoFromSharedPreference();
    displayName = TextEditingController();
    profilePic = TextEditingController();
    username = TextEditingController();
    email = TextEditingController();
    about = TextEditingController();
    gender = TextEditingController();
    address = TextEditingController();
    _dob = TextEditingController();

    var data = Provider.of<GetDataProvider>(context, listen: false).usermodel;

    displayName.text = data.displayName;
    profilePic.text = data.profilePic;
    username.text = data.userName;
    email.text = data.email;
    about.text = data.about;
    gender.text = data.gender;
    address.text = data.address;

    _dob.text = data.dob;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              _submitButton();
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            _userImage(),
            SizedBox(
              height: 15,
            ),
            _entrry(
              "About",
              controller: about,
              maxLine: null,
              // iseditable: true
            ),
            _entry('Name', controller: displayName, iseditable: true),
            _entry('Email',
                controller: email, iseditable: false, isenable: false),
            _entry('Gender',
                controller: gender, iseditable: true, isenable: false),
            _entry('Username',
                controller: username, iseditable: false, isenable: false),
            _entry('Address',
                controller: address, iseditable: false, isenable: false),
            GestureDetector(
              onTap: showCalender,
              child: _entry('Date of birth',
                  controller: _dob, iseditable: true, isenable: false),
            ),
          ],
        ),
      ),
    );
  }
}
