import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/material.dart';

import '../../imageviewer_screen.dart';

class ImageTextMessage extends StatelessWidget {
  const ImageTextMessage({
    Key key,
    @required this.image,
    @required this.message,
    @required this.myuserID,
    // @required this.isuserID,
    @required this.sentBy,
  }) : super(key: key);

  final String image;
  final String myuserID;
  final String message;
  // final String isuserID;
  final String sentBy;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.55, // 60% of total width
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(sentBy == myuserID ? 1 : 0.1),
          borderRadius: sentBy == myuserID ? radius() : radiuss(),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Imageviewer(imageUrl: image)));
              },
              child: AspectRatio(
                aspectRatio: 1.8,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
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
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                message,
                style: TextStyle(
                  color: sentBy == myuserID
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
            )
          ],
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
