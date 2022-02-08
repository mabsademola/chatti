import 'package:chatti/helper/sharedpref_helper.dart';
import 'package:chatti/models/location_model.dart';
import 'package:chatti/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class ProfileProvider extends ChangeNotifier {
   ProfileProvider() {
    getdata();
  }
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserModel usermodel;
 

  getdata() async {
    DocumentSnapshot d = await FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser.uid)
        .get();

    UserModel _usermodel = UserModel(
      userId: d['userId'] ?? await SharedPreferenceHelper().getUserId(),
      email: d['email'] ?? await SharedPreferenceHelper().getUserEmail(),
      displayName:
          d['displayName'] ?? await SharedPreferenceHelper().getdisplayName(),
      userName: d['userName'],
      profilePic:
          d['profilePic'] ?? await SharedPreferenceHelper().getprofilePic(),
      gender: d['gender'] ?? await SharedPreferenceHelper().getGender(),
      dob: d['dob'] ?? await SharedPreferenceHelper().getDob(),
      about: d['about'] ?? await SharedPreferenceHelper().getAbout(),
      address: d['address'],
      isVerified: d['profilePic'],
    );

    usermodel = _usermodel;
    print(usermodel.displayName);

    notifyListeners();
  }

  // getMyInfoFromSharedPreference() async {
  //   UserModel _usermodel = UserModel(
  //     userId: await SharedPreferenceHelper().getUserId(),
  //     email: await SharedPreferenceHelper().getUserEmail(),
  //     displayName: await SharedPreferenceHelper().getdisplayName(),
  //     userName: await SharedPreferenceHelper().getUsername(),
  //     profilePic: await SharedPreferenceHelper().getprofilePic(),
  //     gender: await SharedPreferenceHelper().getGender(),
  //     dob: await SharedPreferenceHelper().getDob(),
  //     about: await SharedPreferenceHelper().getAbout(),
  //     address: await SharedPreferenceHelper().getAddress(),
  //     isVerified: await SharedPreferenceHelper().getisVerified(),

  //     // location: GeoPoint(
  //     //   await SharedPreferenceHelper().getlat(),
  //     //   await SharedPreferenceHelper().getLong(),
  //     // )
  //   );
  //   LocationModel _locationModel = LocationModel(
  //     latitude: await SharedPreferenceHelper().getlat(),
  //     longitude: await SharedPreferenceHelper().getLong(),
  //     address: await SharedPreferenceHelper().getAddress(),
  //   );

  //   usermodel = _usermodel;
  //   locationModel = _locationModel;
  //   notifyListeners();
  // }
}
