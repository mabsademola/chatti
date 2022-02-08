import 'package:chatti/helper/sharedpref_helper.dart';
import 'package:chatti/models/location_model.dart';
import 'package:chatti/models/user_model.dart';
import 'package:flutter/widgets.dart';

class GetDataProvider extends ChangeNotifier {
  GetDataProvider() {
    getMyInfoFromSharedPreference();
  }

  UserModel usermodel;
  LocationModel locationModel;

  getMyInfoFromSharedPreference() async {
    UserModel _usermodel = UserModel(
      userId: await SharedPreferenceHelper().getUserId(),
      email: await SharedPreferenceHelper().getUserEmail(),
      displayName: await SharedPreferenceHelper().getdisplayName(),
      userName: await SharedPreferenceHelper().getUsername(),
      profilePic: await SharedPreferenceHelper().getprofilePic(),
      gender: await SharedPreferenceHelper().getGender(),
      dob: await SharedPreferenceHelper().getDob(),
      about: await SharedPreferenceHelper().getAbout(),
      address: await SharedPreferenceHelper().getAddress(),
      isVerified: await SharedPreferenceHelper().getisVerified(),

      // location: GeoPoint(
      //   await SharedPreferenceHelper().getlat(),
      //   await SharedPreferenceHelper().getLong(),
      // )
    );
    LocationModel _locationModel = LocationModel(
      latitude: await SharedPreferenceHelper().getlat(),
      longitude: await SharedPreferenceHelper().getLong(),
      address: await SharedPreferenceHelper().getAddress(),
    );

    usermodel = _usermodel;
    locationModel = _locationModel;
    notifyListeners();
  }
}
