import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/material.dart';

import 'Profile/components/circular_image.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key key,
    @required this.profileUrl,
    @required this.name,
    @required this.userName,
    @required this.press,
    @required this.read,
    @required this.timestamp,
    @required this.badgeCount,
    @required this.isuserid,
    @required this.active,
    @required this.myuserid,
  }) : super(key: key);

  // final Chat chat;
  final String profileUrl,
      name,
      active,
      userName,
      timestamp,
      isuserid,
      myuserid;
  final int badgeCount;
  final bool read;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kkDefaultPadding * 0.75),
        child: Row(
          children: [
            Stack(
              children: [
                CircularImage(path: profileUrl, height: 50),
                if (active == "online")
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: kOnlineColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 3),
                      ),
                    ),
                  ),
                if (active == "offline")
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: kContentColorDarkTheme,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 3),
                      ),
                    ),
                  ),
                if (active == "away")
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 3),
                      ),
                    ),
                  ),
                if (active == null)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: kContentColorDarkTheme,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 3),
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Opacity(
                  opacity: 0.64,
                  child: Text(timestamp),
                ),
                isuserid == myuserid
                    ? Container()
                    : badgeCount == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: CircleAvatar(
                              radius: 9,
                              child: Text(
                                badgeCount == null
                                    ? ""
                                    : badgeCount != 0
                                        ? badgeCount.toString()
                                        : "",
                                style: TextStyle(fontSize: 10),
                              ),
                              backgroundColor: badgeCount == 0
                                  ? Colors.transparent
                                  : kPrimaryColor,
                              foregroundColor: Colors.white,
                            )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
