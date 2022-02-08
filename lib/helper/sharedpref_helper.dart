import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String userIdKey = "userIdKey ";
  static String userEmailKey = "userEmailKey";
  static String displayNameKey = "displayNameKey";
  static String userNameKey = " userNameKey";
  static String profilePicKey = "profilePicKey";
  static String genderKey = "genderKey";
  static String dobKey = "dobKey";
  static String aboutKey = "aboutKey";
  static String addressKey = "addressKey";
  static String isVerifiedKey = "isVerifiedKey";
  static String latKey = "latitudeKey";
  static String longKey = "longitudeKey";

  //save data

  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserEmail);
  }

  Future<bool> savedisplayName(String getdisplayName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(displayNameKey, getdisplayName);
  }

  Future<bool> saveUsername(String getUsername) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUsername);
  }

  Future<bool> saveprofilePic(String getprofilePic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(profilePicKey, getprofilePic);
  }

  Future<bool> saveGender(String getGender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(genderKey, getGender);
  }

  Future<bool> saveDob(String getDob) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(dobKey, getDob);
  }

  Future<bool> saveAbout(String getAbout) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(aboutKey, getAbout);
  }

  Future<bool> saveAddress(String getAddress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(addressKey, getAddress);
  }

  Future<bool> saveLong(double getLong) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(longKey, getLong);
  }

  Future<bool> saveLat(double getLat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(latKey, getLat);
  }

  Future<bool> saveisVerified(bool getisVerified) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isVerifiedKey, getisVerified);
  }

//get userdata
  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey) ?? "";
  }

  Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey) ?? "";
  }

  Future<String> getdisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(displayNameKey) ?? "";
  }

  Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey) ?? "";
  }

  Future<String> getprofilePic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(profilePicKey) ?? "";
  }

  Future<String> getGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(genderKey) ?? "";
  }

  Future<String> getDob() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(dobKey) ?? "";
  }

  Future<String> getAbout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(aboutKey) ?? "";
  }

  Future<String> getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(addressKey) ?? "";
  }

  Future<bool> getisVerified() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isVerifiedKey) ?? false;
  }

  Future<double> getlat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(latKey) ?? 0;
  }

  Future<double> getLong() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(longKey) ?? 0;
  }
}

  // Future<void> saveUserProfile(UserModel user) async {
  //   return (await SharedPreferences.getInstance()).setString(
  //       UserPreferenceKey.UserProfile.toString(), json.encode(user.toJson()));
  // }

 
  

  // Future<UserModel> getUserProfile() async {
  //   final jsonString = (await SharedPreferences.getInstance())
  //       .getString(UserPreferenceKey.UserProfile.toString());
  //   if (jsonString == null) return null;
  //   return UserModel.fromJson(json.decode(jsonString));
  // }
