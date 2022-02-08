import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class LoginUserModel {
  GeoPoint location;
  GeoFirePoint locations;
  String address;
  var lastSeen;

  LoginUserModel({
    this.lastSeen,
    this.location,
    this.locations,
    this.address,
  });
  toJson() {
    return {
      'location': location,
      'address': address,
    };
  }
}
