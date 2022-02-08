// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:chatti/extensions/title_text.dart';
import 'package:chatti/helper/sharedpref_helper.dart';

import 'package:chatti/provider/getdata_provider.dart';
import 'package:chatti/screens/Profile/components/circular_image.dart';
import 'package:chatti/screens/Profile/components/headerWidget.dart';
import 'package:chatti/util/loadings.dart';
import 'package:chatti/utility.dart/theme.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key key}) : super(key: key);

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  File _image;

  TextEditingController profilePic, about;
  final FirebaseAuth auth = FirebaseAuth.instance;
  CustomLoader loader = CustomLoader();

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

  Future<void> _submitButton() async {
    loader.showLoader(
      context,
    );

    if (about.text.isNotEmpty && _image == null) {
      try {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(auth.currentUser.uid)
            .update({
          'about': about.text ?? "Hey guys, i'm new to Chatti",
        }).whenComplete(() {
          SharedPreferenceHelper()
              .saveAbout(about.text ?? "Hey guys, i'm new to Chatti");
          Provider.of<GetDataProvider>(context, listen: false)
              .getMyInfoFromSharedPreference();
          Navigator.pop(context);
        });
        _image = null;
      } catch (e) {
        loader.hideLoader();
        GFToast.showToast(e, context,
            toastPosition: GFToastPosition.BOTTOM,
            textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
            backgroundColor: GFColors.LIGHT,
            trailing: Icon(
              CupertinoIcons.exclamationmark_circle_fill,
              color: kPrimaryColor,
            ));
      }
    }

    if (_image != null && about.text.isEmpty) {
      try {
        Reference uploadimg = FirebaseStorage.instance.ref().child(_image.path);

        UploadTask uploadTask = uploadimg.putFile(_image);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        var imageurl = (await taskSnapshot.ref.getDownloadURL()).toString();
        print(imageurl);

        FirebaseFirestore.instance
            .collection("Users")
            .doc(auth.currentUser.uid)
            .update({
          'profilePic': imageurl,
        }).whenComplete(() {
          SharedPreferenceHelper().saveprofilePic(imageurl);
          Provider.of<GetDataProvider>(context, listen: false)
              .getMyInfoFromSharedPreference();
          Navigator.pop(context);
        });
        _image = null;
      } catch (e) {
        loader.hideLoader();
        GFToast.showToast(e, context,
            toastPosition: GFToastPosition.BOTTOM,
            textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
            backgroundColor: GFColors.LIGHT,
            trailing: Icon(
              CupertinoIcons.exclamationmark_circle_fill,
              color: kPrimaryColor,
            ));
        print(e);
      }
    }

    if (_image != null && about.text.isNotEmpty) {
      try {
        Reference uploadimg = FirebaseStorage.instance.ref().child(_image.path);

        UploadTask uploadTask = uploadimg.putFile(_image);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        var imageurl = (await taskSnapshot.ref.getDownloadURL()).toString();
        print(imageurl);

        FirebaseFirestore.instance
            .collection("Users")
            .doc(auth.currentUser.uid)
            .update({
          'profilePic': imageurl,
          'about': about.text ?? "Hey guys, i'm new to Chatti",
        }).whenComplete(() {
          SharedPreferenceHelper().saveprofilePic(imageurl);
          SharedPreferenceHelper()
              .saveAbout(about.text ?? "Hey guys, i'm new to Chatti");
          Provider.of<GetDataProvider>(context, listen: false)
              .getMyInfoFromSharedPreference();
          Navigator.pop(context);
        });
        _image = null;
      } catch (e) {
        loader.hideLoader();
        GFToast.showToast(e, context,
            toastPosition: GFToastPosition.BOTTOM,
            textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
            backgroundColor: GFColors.LIGHT,
            trailing: Icon(
              CupertinoIcons.exclamationmark_circle_fill,
              color: kPrimaryColor,
            ));
        print(e);
      }
    }
  }

  Widget _entrry(String title,
      {TextEditingController controller,
      String hint,
      int maxLine = 1,
      bool limit = false,
      bool isenable = true}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: TextField(
          enabled: isenable,
          controller: controller,
          maxLines: maxLine,
          inputFormatters:
              limit ? [LengthLimitingTextInputFormatter(300)] : null,
          decoration: InputDecoration.collapsed(hintText: hint),
        ),
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

  getImage(BuildContext context, ImageSource source,
      Function(File) onImageSelected) {
    ImagePicker()
        .pickImage(source: source, imageQuality: 50)
        .then((XFile file) {
      onImageSelected(File(file.path));
      Navigator.pop(context);
    });
  }

  Future<void> onpress() async {
    if (about.text != "" && _image == null) {
      // _resetTextFieldAndLoading();

      try {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(auth.currentUser.uid)
            .update({
          "about": about.text,
          // "profilePic": "profilePic",
        });
      } catch (e) {
        print(e);
      }
    }

    if (_image != null && about.text != "") {
      // _resetTextFieldAndLoading();
      try {
        Reference uploadimg = FirebaseStorage.instance
            .ref(auth.currentUser.uid)
            .child(_image.path);

        UploadTask uploadTask = uploadimg.putFile(_image);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        var imageurl = (await taskSnapshot.ref.getDownloadURL()).toString();
        print(imageurl);
        FirebaseFirestore.instance
            .collection("Users")
            .doc(auth.currentUser.uid)
            .update({
          "about": about.text,
          "profilePic": imageurl,
        }).whenComplete(() {
          SharedPreferenceHelper().saveAbout(about.text ?? "");
          SharedPreferenceHelper().saveprofilePic(imageurl ?? "");
          Navigator.pop(context);
        });
        _image = null;
        print("done sending");
      } catch (e) {
        print(e);
      }
    }
  }

  Widget _userImage() {
    var data = Provider.of<GetDataProvider>(context, listen: false).usermodel;
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0),
        height: 200,
        width: 200,
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
    // getMyInfoFromSharedPreference();

    profilePic = TextEditingController();

    about = TextEditingController();

    var data = Provider.of<GetDataProvider>(context, listen: false).usermodel;

    profilePic.text = data.profilePic;

    // about.text = data.about;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
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
                    fontSize: 19,
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
            HeaderWidget(
              'About',
            ),
            _entrry(
              "About",
              hint: "Tell your friends a little bit about youself",
              limit: true,
              controller: about,
              maxLine: null,
            ),
          ],
        ),
      ),
    );
  }
}
