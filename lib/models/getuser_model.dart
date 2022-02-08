import 'package:geoflutterfire/geoflutterfire.dart';

class Users {
  String userId;
  String email;
  String displayName;
  String userName;
  String profilePic;
  String gender;
  String dob;
  // GeoPoint location;
  GeoFirePoint location;
  String about;
  String address;
  bool isVerified;
  var createdAt;
  var lastSeen;
  String active;

  Users({
    this.userId,
    this.email,
    this.displayName,
    this.userName,
    this.profilePic,
    this.lastSeen,
    this.gender,
    this.dob,
    this.active,
    this.location,
    this.about,
    this.address,
    this.isVerified,
    this.createdAt,
  });
}
