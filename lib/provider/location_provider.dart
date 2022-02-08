// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:chatti/helper/sharedpref_helper.dart';
import 'package:chatti/models/location_model.dart';
import 'package:chatti/models/user_model.dart';
import 'package:chatti/provider/getdata_provider.dart';
import 'package:chatti/services/database.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import 'package:geolocator/geolocator.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

class LocationProvider with ChangeNotifier {
  LocationProvider() {
    handlePermission();
    getCurrentPosition();
    getPrefs();
  }
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final geo = Geoflutterfire();
  DatabaseMethods db = DatabaseMethods();

  final FirebaseAuth auth = FirebaseAuth.instance;
  // var getlat;
  // var getlong;
  double mylat = null;
  double mylong = null;
  var address;

  UserModel usermodel;
  LocationModel locationModel;

  Future<bool> handlePermission({BuildContext context}) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      GFToast.showToast(
          " You can't continue without turning on your location", context,
          toastPosition: GFToastPosition.BOTTOM,
          textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
          backgroundColor: GFColors.WARNING,
          trailing: Icon(
            CupertinoIcons.exclamationmark_triangle_fill,
            color: kPrimaryColor,
          ));

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // _updatePositionList(
        //   _PositionItemType.log,
        //   _kPermissionDeniedMessage,
        // );

        GFToast.showToast(
            "Permission denied, You can't continue without turn on your location",
            context,
            toastPosition: GFToastPosition.BOTTOM,
            textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
            backgroundColor: GFColors.WARNING,
            trailing: Icon(
              CupertinoIcons.exclamationmark_triangle_fill,
              color: kPrimaryColor,
            ));

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      GFToast.showToast(
          "Permission denied forever, You can't continue without turn on your location",
          context,
          toastPosition: GFToastPosition.BOTTOM,
          textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
          backgroundColor: GFColors.WARNING,
          trailing: Icon(
            CupertinoIcons.exclamationmark_triangle_fill,
            color: kPrimaryColor,
          ));
      // Permissions are denied forever, handle appropriately.
      // _updatePositionList(
      //   _PositionItemType.log,
      //   _kPermissionDeniedForeverMessage,
      // );

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return true;
  }

  Future<void> getCurrentPosition(
      {BuildContext context, bool auto = false}) async {
    final hasPermission = await handlePermission(context: context);

    if (!hasPermission) {
      return Navigator.of(context).pushNamed('/Locationdis');
    }
    // try {
    final position = await _geolocatorPlatform.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placemark = placemarks[0];

      String formattedAddress = "${placemark.locality}, ${placemark.country}";
      mylat = position.latitude;
      mylong = position.longitude;
      address = formattedAddress;

      GeoFirePoint location = geo.point(
          latitude: position.latitude ?? 0, longitude: position.longitude ?? 0);

      // this.address = formattedAddress;

      UserModel _userModeel = UserModel(
        address: formattedAddress,
        location: location,
      );
      usermodel = _userModeel;

      if (auto) {
        await db.user.doc(auth.currentUser.uid).update({
          'location': usermodel.location,
          'address': usermodel.address,
        });

        SharedPreferenceHelper().saveAddress(formattedAddress);
        SharedPreferenceHelper().saveLat(position.latitude);
        SharedPreferenceHelper().saveLong(position.longitude);
        Provider.of<LocationProvider>(context, listen: false).getPrefs();
        Provider.of<GetDataProvider>(context, listen: false)
            .getMyInfoFromSharedPreference();
      }
      notifyListeners();
      return usermodel;
    } else {
      GFToast.showToast(
          "An error occur, please make sure your location and internet connection is turn on",
          context,
          toastPosition: GFToastPosition.BOTTOM,
          textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
          backgroundColor: GFColors.WARNING,
          trailing: Icon(
            CupertinoIcons.exclamationmark_triangle_fill,
            color: kPrimaryColor,
          ));
    }
    // } catch (e) {
    //   GFToast.showToast(
    //       "An error occur, please make sure your location and internet connection is turn on",
    //       context,
    //       toastPosition: GFToastPosition.BOTTOM,
    //       textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
    //       backgroundColor: GFColors.WARNING,
    //       trailing: Icon(
    //         CupertinoIcons.exclamationmark_triangle_fill,
    //         color: kPrimaryColor,
    //       ));
    // }
  }

  getPrefs() async {
    LocationModel _locationModel = LocationModel(
      latitude: await SharedPreferenceHelper().getlat() ?? 0,
      address: await SharedPreferenceHelper().getAddress() ?? 0,
      longitude: await SharedPreferenceHelper().getLong() ?? 0,
    );
    locationModel = _locationModel;
    notifyListeners();
  }

  String getDistance(var location) {
    GeoPoint point = location;

    // double distanceKm = 9;
    if (mylat != null && mylong != null) {
      double distance = Geolocator.distanceBetween(
        mylat,
        mylong,
        point.latitude,
        point.longitude,
      );

      return distancecal(distance);
    } else {
      return "Unknown";
    }
  }

  distancecal(double distance) {
    double distanceKm = 9;
    if (distance <= 999) {
      return distance.toStringAsFixed(2) + " m Away";
    } else if (distance > 999 && distance <= 1609) {
      distanceKm = distance / 1000;
      return distanceKm.toStringAsFixed(2) + " Km Away";
    } else if (distance > 1609) {
      distanceKm = distance / 1609;
      return distanceKm.toStringAsFixed(2) + " mi Away";
    }
  }
}
