import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/material.dart';

import '../../imageviewer_screen.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage({
    Key key,
    @required this.image,
    @required this.myuserID,
    // @required this.isuserID,
    @required this.sentBy,
  }) : super(key: key);

  final String image;
  final String myuserID;
  // final String isuserID;
  final String sentBy;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.55, // 45% of total width
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Imageviewer(imageUrl: image)));
        },
        child: AspectRatio(
          aspectRatio: 1.6,
          child: ClipRRect(
              borderRadius: sentBy == myuserID ? radius() : radiuss(),
              child: Container(
                // width: 100,
                height: MediaQuery.of(context).size.height * 0.60,

                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          image,
                        ),
                        fit: BoxFit.cover)),
              )),
        ),
      ),
    );
  }

  BorderRadius radius() {
    return BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(0),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20));
  }

  BorderRadius radiuss() {
    return BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(0));
  }
}
