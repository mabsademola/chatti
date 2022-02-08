import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  // final bool isActive;
  // final bool hasBorder;

  const ProfileAvatar({
    Key key,
    @required this.imageUrl,
    @required this.radius,
    // this.isActive = false,
    // this.hasBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[200],
      backgroundImage: CachedNetworkImageProvider(imageUrl),
    );
  }
}
