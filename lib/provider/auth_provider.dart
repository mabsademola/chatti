// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:chatti/dialogs/dialog.dart';
import 'package:chatti/helper/enum.dart';
import 'package:chatti/helper/sharedpref_helper.dart';
import 'package:chatti/helper/utility.dart';

import 'package:chatti/models/user_model.dart';

import 'package:chatti/screens/screens.dart';

import 'package:chatti/util/loadings.dart';

import 'package:chatti/utility.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:getwidget/getwidget.dart';

// import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'getdata_provider.dart';

class AuthProvider extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final usersDb = FirebaseFirestore.instance.collection("Users");
  UserModel _userModel;

  User user;
  String userId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel get userModel => _userModel;
  bool isSignInWithGoogle = false;
  // UserModel get profileUserModel => _userModel;
  CustomLoader loader = CustomLoader();
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Create new user's profile in db
  Future<String> registerWithEmailAndPassword(
    UserModel userModel,
    String password,
    BuildContext context,
  ) async {
    // loader.showLoader(
    //   context,
    // );
    try {
      // loading = true;
      UserCredential result = await _auth
          .createUserWithEmailAndPassword(
        email: userModel.email,
        password: password,
      )
          .catchError((error) {
        print(error);
        throw Exception(error
            .toString()
            .replaceAll((r'[firebase_auth/network-request-failed] '), "")
            .replaceAll((r'[firebase_auth/email-already-in-use] '), ""));
      });
      _userModel = userModel;
      user = result.user;
      print("getting data");
      _userModel.userId = result.user.uid;
      result.user.updatePhotoURL(userModel.profilePic);
      result.user.updateDisplayName(userModel.displayName);
      // FirebaseFirestore.instance.collection("Users").doc(user.uid).set({
      //   "email": user.email,
      //   'displayName': user.displayName,
      //   // 'profilePic': userModel.profilePic ?? userModel.gender == "female"
      //   //     ? womaning
      //   //     : maleimg,
      //   // 'lastSeen': user.lastSeen,
      //   // 'gender': userModel.gender ?? "genderless",
      // }).whenComplete(() => loader.hideLoader());

      storeUser(_userModel, newUser: true, context: context);

      return user.uid;
    } on Exception catch (error) {
      loader.hideLoader();
      GFToast.showToast(
          error.toString().replaceAll((r'Exception: '), ""), context,
          toastPosition: GFToastPosition.BOTTOM,
          textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
          backgroundColor: GFColors.LIGHT,
          trailing: Icon(
            CupertinoIcons.exclamationmark_circle_fill,
            color: kPrimaryColor,
          ));

      return null;
    }
  }

  storeUser(
    UserModel user, {
    bool newUser = true,
    BuildContext context,
  }) async {
    print("giveee");
    if (newUser) {
      // Create username by the combination of name and id
      user.userName =
          Utility.getUserName(id: user.userId, name: user.displayName);
      // kAnalytics.logEvent(name: 'create_newUser');
      print(user.userName);
    }

    print(user.address);
    // print(user.location);
    // print(user.locations);

    await FirebaseFirestore.instance.collection("Users").doc(user.userId).set(
            // user.toJson()
            {
          "userId": user.userId,
          "email": user.email,
          'displayName': user.displayName,
          'lastSeen': user.lastSeen,
          'gender': user.gender ?? "genderless",
          'dob': user.dob,
          'apologyList': user.apologyList,
          'about': user.about ?? "Hey guys, i'm new to Chatti",
          'active': user.active ?? "offline",
          'createdAt': user.createdAt,
          'userName': user.userName ?? "",
          'profilePic': user.profilePic,
          "notifcount": 0,
          "chatcount": 0,
          'location': user.location.data,
          'address': user.address ?? "Unknown",
        })
        // .whenComplete(() => loader.hideLoader());
        .whenComplete(() {
      print("done");
      //saveuserData
      SharedPreferenceHelper().saveUserId(user.userId);
      SharedPreferenceHelper().saveUserEmail(user.email);
      SharedPreferenceHelper().savedisplayName(user.displayName);
      SharedPreferenceHelper().saveUsername(user.userName ?? "");
      SharedPreferenceHelper().saveprofilePic(user.profilePic);
      SharedPreferenceHelper().saveGender(user.gender ?? "genderless");
      SharedPreferenceHelper().saveDob(user.dob);
      SharedPreferenceHelper()
          .saveAbout(user.about ?? "Hey guys, i'm new to Chatti");
      SharedPreferenceHelper().saveAddress(user.address ?? "Unknown");
      SharedPreferenceHelper().saveisVerified(user.isVerified ?? false);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Navigation(),
          ));
      Navigator.of(context).pushNamed('/PersonalInfo');
      Provider.of<GetDataProvider>(context, listen: false)
          .getMyInfoFromSharedPreference();

      loader.hideLoader();
    });

    _userModel = user;
    // loading = false;
  }

  /// Verify user's credentials for login
  Future<String> loginWithEmailAndPassword(String email, String password,
      BuildContext context, UserModel userModel) async {
    loader.showLoader(
      context,
    );
    try {
      // loading = true;
      var result = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((error) {
        throw Exception(error
            .toString()
            .replaceAll((r'[firebase_auth/network-request-failed] '), "")
            .replaceAll((r'[FirebaseAuthException] '), ""));
      });
      print("login succ");

      user = result.user;
      userId = user.uid;

      _userModel = userModel;

      if (result != null) {
        DocumentSnapshot d = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();
        print("oya ooo");
        SharedPreferenceHelper().saveUserId(user.uid ?? "");
        SharedPreferenceHelper().saveUserEmail(user.email ?? "");
        SharedPreferenceHelper().savedisplayName(user.displayName ?? "");
        SharedPreferenceHelper().saveUsername(d['userName'] ?? "");
        SharedPreferenceHelper().saveprofilePic(user.photoURL ?? "");
        SharedPreferenceHelper().saveGender(d['gender'] ?? "");
        SharedPreferenceHelper().saveDob(d['dob'] ?? "");
        SharedPreferenceHelper().saveAbout(d['about'] ?? "");
        SharedPreferenceHelper().saveAddress(d['address'] ?? "");

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Navigation(),
            ));

        Provider.of<GetDataProvider>(context, listen: false)
            .getMyInfoFromSharedPreference();

        loader.hideLoader();
        GFToast.showToast("Welcome Back ${user.displayName}", context,
            toastPosition: GFToastPosition.BOTTOM,
            textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
            backgroundColor: GFColors.LIGHT,
            trailing: Icon(
              CupertinoIcons.exclamationmark_circle_fill,
              color: kPrimaryColor,
            ));
      }

      return user.uid;
    } on Exception catch (error) {
      loader.hideLoader();
      GFToast.showToast(
          error.toString().replaceAll((r'Exception: '), ""), context,
          toastPosition: GFToastPosition.BOTTOM,
          textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
          backgroundColor: GFColors.LIGHT,
          trailing: Icon(
            CupertinoIcons.exclamationmark_circle_fill,
            color: kPrimaryColor,
          ));

      return null;
    }
  }

// signOut from device
  Future signOut(
    BuildContext context,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await _auth.signOut().catchError((error) {
        throw Exception(error
            .toString()
            .replaceAll((r'[firebase_auth/network-request-failed] '), "")
            .replaceAll((r'[FirebaseAuthException] '), ""));
      });

      userId = '';
      _userModel = null;
      user = null;
      prefs.clear();
      notifyListeners();
    } on Exception catch (error) {
      loader.hideLoader();
      GFToast.showToast(
          error.toString().replaceAll((r'Exception: '), ""), context,
          toastPosition: GFToastPosition.BOTTOM,
          textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
          backgroundColor: GFColors.LIGHT,
          trailing: Icon(
            CupertinoIcons.exclamationmark_circle_fill,
            color: kPrimaryColor,
          ));

      return null;
    }
  }

  /// Send email verification link to email2
  Future<void> sendEmailVerification(
      GlobalKey<ScaffoldState> scaffoldKey) async {
    User user = _auth.currentUser;
    user.sendEmailVerification().then((_) {
      Utility.customSnackBar(
        scaffoldKey,
        'An email verification link is send to your email.',
      );
    }).catchError((error) {
      print(error);

      Utility.customSnackBar(
        scaffoldKey,
        error.message,
      );
    });
  }

  // Future<String> _uploadFileToStorage(File file, path) async {
  //   var task = _firebaseStorage.ref().child(path);
  //   var status = await task.putFile(file);
  //   print(status.state);

  //   /// get file storage path from server
  //   return await task.getDownloadURL();
  // }

  /// `Update user` profile
  Future<void> updateUserProfile(UserModel userModel, {File image}) async {
    try {
      if (image == null) {
        setUserdata(userModel);
      } else {
        /// upload profile image if not null
        if (image != null) {
          //  get image storage path from server
          // userModel.profilePic = await _uploadFileToStorage(image,
          // 'user/profile/${userModel.userName}/${Path.basename(image.path)}');
          // print(fileURL);
          var name = userModel?.displayName ?? user.displayName;
          _auth.currentUser.updatePhotoURL(userModel.profilePic);
          _auth.currentUser.updateDisplayName(name);
        }

        if (userModel != null) {
          setUserdata(userModel);
        } else {
          setUserdata(_userModel);
        }
      }
    } catch (error) {
      print(error);
    }
  }

  // /// `Fetch` user `detail` whoose userId is passed
  // Future<UserModel> getuserDetail(String userId) async {
  //   UserModel user;
  //   usersDb.doc(userId).get().then((DocumentSnapshot snapshot) {
  //     if (snapshot.data() != null) {
  //       var map = snapshot.data();
  //       user = UserModel.fromJson(map);
  //     }
  //   });
  // }

  /// Send password reset link to email
  Future<void> forgetPassword(
    String email,
    BuildContext context,
  ) async {
    try {
      await _auth.sendPasswordResetEmail(email: email).then((value) {
        print("done ni yess");

        Dialogs().showFGDialog(context);
      }).catchError((error) {
        print(error);
        // ignore: valid_regexps
        GFToast.showToast(
            error.toString().replaceAll(
                // ignore: valid_regexps
                RegExp(r'[firebase_auth/network-request-failed] '),
                ''),
            context,
            toastPosition: GFToastPosition.BOTTOM,
            textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
            backgroundColor: GFColors.LIGHT,
            trailing: Icon(
              CupertinoIcons.exclamationmark_circle,
              color: GFColors.DANGER,
            ));

        return false;
      });
    } catch (error) {
      GFToast.showToast(
          error.toString().replaceAll(
              // ignore: valid_regexps
              RegExp(r'[firebase_auth/network-request-failed] '),
              ''),
          context,
          toastPosition: GFToastPosition.BOTTOM,
          textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
          backgroundColor: GFColors.LIGHT,
          trailing: Icon(
            CupertinoIcons.exclamationmark_circle,
            color: GFColors.DANGER,
          ));

      // print(error);
      // Utility.customSnackBar(scaffoldKey, error.message);
      // return Future.value(false);
    }
  }

  /// Check if user's email is verified
  Future<bool> emailVerified() async {
    User user = _auth.currentUser;
    return user.emailVerified;
  }

  /// `Create` and `Update` user
  /// IF `newUser` is true new user is created
  /// Else existing user will update with new values
  Future setUserdata(UserModel user,
      {bool newUser = false, BuildContext context}) {
    // user.createdAt = DateTime.now().toUtc().toString();
    user.lastSeen = DateTime.now().microsecondsSinceEpoch;
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user.userId)
        .set(user.toJson())
        .whenComplete(() {
      Navigator.pushReplacementNamed(context, "/Navigation");
      loader.hideLoader();
    });

    if (newUser) {
      user.userName =
          Utility.getUserName(id: user.userId, name: user.displayName);

      // user.createdAt = DateTime.now().toUtc().toString();
      // user.lastSeen = DateTime.now().toUtc().toString();

      FirebaseFirestore.instance
          .collection("Users")
          .doc(user.userId)
          .set(user.toJson())
          .whenComplete(() {
        Navigator.pushReplacementNamed(context, "/Navigation");
        loader.hideLoader();
      });
    }
    //saveuserData
    SharedPreferenceHelper().saveUserId(user.userId ?? "");
    SharedPreferenceHelper().saveUserEmail(user.email ?? "");
    SharedPreferenceHelper().savedisplayName(user.displayName ?? "");
    SharedPreferenceHelper().saveUsername(user.userName ?? "");
    SharedPreferenceHelper().saveprofilePic(user.profilePic ?? "");
    SharedPreferenceHelper().saveGender(user.gender ?? "");
    SharedPreferenceHelper().saveDob(user.dob ?? "");
    SharedPreferenceHelper().saveAbout(user.about ?? "");
    SharedPreferenceHelper().saveAddress(user.address ?? "");
    SharedPreferenceHelper().saveisVerified(user.isVerified ?? "");

    // FirebaseFirestore.instance
    //     .collection("Users")
    //     .doc(user.userId)
    //     .set(user.toJson());

    // _userModel = user;
    // loading = false;
  }

// // Fetch current user profile
//   Future<User> getCurrentUser() async {
//     try {
//       loading = true;

//       user = _auth.currentUser;
//       if (user != null) {
//         authStatus = AuthStatus.LOGGED_IN;
//         userId = user.uid;
//         getProfileUser();
//       } else {
//         authStatus = AuthStatus.NOT_LOGGED_IN;
//       }
//       loading = false;
//       return user;
//     } catch (e) {
//       loading = false;
//       print(e);
//       authStatus = AuthStatus.NOT_LOGGED_IN;
//       return null;
//     }
//   }

// // Fetch user profile
//   getProfileUser({String userProfileId}) {
//     try {
//       loading = true;

//       userProfileId = userProfileId == null ? user.uid : userProfileId;
//       usersDb.doc(userProfileId).get().then((DocumentSnapshot snapshot) {
//         if (snapshot.data() != null) {
//           var map = snapshot.data();
//           if (map != null) {
//             if (userProfileId == user.uid) {
//               _userModel = UserModel.fromJson(map);

//               // _userModel.isVerified = user.emailVerified;
//               // if (!user.emailVerified) {

//               //   reloadUser();
//               // }

//               var user = _userModel;

//               //saveuserData

//               SharedPreferenceHelper().saveUserId(user.userId);
//               SharedPreferenceHelper().saveUserEmail(user.email);
//               SharedPreferenceHelper().savedisplayName(user.displayName);
//               SharedPreferenceHelper().saveUsername(user.userName);
//               SharedPreferenceHelper().saveprofilePic(user.profilePic);
//               SharedPreferenceHelper().saveGender(user.gender);
//               // SharedPreferenceHelper().saveDob(user.dob);
//               SharedPreferenceHelper().saveAbout(user.about);
//               SharedPreferenceHelper().saveAddress(user.address);

//               SharedPreferenceHelper().saveisVerified(user.isVerified);
//             }
//           }
//         }
//       });
//     } catch (error) {
//       loading = false;
//       print(error);
//     }
//   }

  reloadUser() async {
    await user.reload();
    user = _auth.currentUser;
    if (user.emailVerified) {
      userModel.isVerified = true;

      setUserdata(userModel);
      print('UserModel email verification complete');
    }
  }
}
