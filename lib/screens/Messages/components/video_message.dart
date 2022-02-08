import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/material.dart';

class VideoMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45, // 45% of total width
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset("assets/images/Video Place Here.png"),
            ),
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                size: 16,
                color: Colors.white,
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
