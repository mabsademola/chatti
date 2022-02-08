import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatti/helper/database.dart';
import 'package:chatti/screens/ListChats/Stories.dart';

import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final String img;
  final String name;
  const StoryItem({
    Key key,
    this.img,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StoryScreen(stories: stories),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 4, bottom: 15),
        child: Column(
          children: <Widget>[
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: storyBorderColor)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  width: 53,
                  height: 53,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            img,
                          ),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 70,
              child: Text(
                name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,

                // style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Addstoryitem extends StatelessWidget {
  final String img;
  final String name;
  const Addstoryitem({
    Key key,
    this.img,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 15),
      child: Column(
        children: <Widget>[
          Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Icon(
                Icons.add,
                size: 35,
              )),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            width: 70,
            child: Text(
              "Your story",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
