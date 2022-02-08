class UserInfoGetter {
  final String userId;
  final String email;
  final String name;
  final String username;
  final String imgUrl;
  final String gender;
  final String creationTime;
  final String location;
  final String about;
  final bool isVerified;

  UserInfoGetter(
      {this.userId,
      this.name,
      this.email,
      this.imgUrl,
      this.gender,
      this.username,
      this.creationTime,
      this.location,
      this.about,
      this.isVerified});
}
