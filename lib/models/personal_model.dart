import 'package:chatti/helper/sharedpref_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class PersonalModel {
  String userId = "";
  String email = "";
  String displayName = SharedPreferenceHelper().getdisplayName() as String;
  String userName = SharedPreferenceHelper().getUsername() as String;
  String profilePic = SharedPreferenceHelper().getprofilePic() as String;
  String gender = "";
  String dob = SharedPreferenceHelper().getAbout() as String;
  var location;
  String about = "";
  String address = "";
  bool isVerified;
  // int notifcount = 0;
  // int chatcount = 0;
  var createdAt;
  var lastSeen;
  String active;

  List<String> friendsList;
  List<String> blockList;

  List<String> apologyList;

  PersonalModel({
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
    // this.notifcount,
    // this.chatcount,
    this.friendsList,
    this.apologyList,
    this.blockList,
  });

  factory PersonalModel.fromDocument(DocumentSnapshot doc) {
    return doc != null
        ? PersonalModel(
            userId: doc['userId'],
            displayName: doc['displayName'],
            userName: doc['userName'],
            profilePic: doc['profilePic'],
            gender: doc['gender'],
            dob: doc['dob'],
            about: doc['about'],
            // notifcount: doc['notifcount'],
            // chatcount: doc['chatcount'],
            address: doc['address'],
            location: doc['location']['geopoint'],
            active: doc['active'],
          )
        : null;
  }

  toJson() async {
    return {
      "userId": userId,
      "email": email,
      'displayName': displayName,
      'lastSeen': lastSeen,
      'gender': gender ?? "genderless",
      'dob': dob,
      'apologyList': apologyList,
      'about': about ?? "Hey guys, i'm new to Chatti",
      'active': active ?? "offline",
      'createdAt': createdAt,
      'userName': userName ?? "",
      'profilePic': profilePic,
      'locations': location,
      // 'location': location,
      'address': address ?? "Unknown",
    };
  }

  PersonalModel copyWith({
    String email,
    String userId,
    String displayName,
    String profilePic,
    String gender,
    String about,
    String dob,
    String location,
    String createdAt,
    String userName,
    int friends,
    int address,
    bool isVerified,
    List<String> groupList,
    List<String> friendsList,
  }) {
    return PersonalModel(
      email: email ?? this.email,
      about: about ?? this.about,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
      displayName: displayName ?? this.displayName,
      dob: dob ?? this.dob,

      address: address ?? this.address,
      isVerified: isVerified ?? this.isVerified,
      // location: location ?? this.location,
      profilePic: profilePic ?? this.profilePic,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      friendsList: friendsList ?? this.friendsList,
    );
  }
}
