import 'package:chatti/screens/Profile/components/circular_image.dart';

import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    Key key,
    @required this.profileUrl,
    @required this.name,
    @required this.userName,
    @required this.press,
  }) : super(key: key);

  final String profileUrl, name, userName;
  final VoidCallback press;
  // final UserModel user;

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
                // if (chat.isActive)
                //   Positioned(
                //     right: 0,
                //     bottom: 0,
                //     child: Container(
                //       height: 18,
                //       width: 18,
                //       decoration: BoxDecoration(
                //         color: kOnlineColor,
                //         shape: BoxShape.circle,
                //         border: Border.all(
                //             color: Theme.of(context).scaffoldBackgroundColor,
                //             width: 3),
                //       ),
                //     ),
                //   ),
                // if (!chat.isActive)
                //   Positioned(
                //     right: 0,
                //     bottom: 0,
                //     child: Container(
                //       height: 18,
                //       width: 18,
                //       decoration: BoxDecoration(
                //         color: kErrorColor,
                //         shape: BoxShape.circle,
                //         border: Border.all(
                //             color: Theme.of(context).scaffoldBackgroundColor,
                //             width: 3),
                //       ),
                //     ),
                //   ),
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
                        "@$userName",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Opacity(
            //   opacity: 0.64,
            //   child: Text(chat.time),
            // ),
          ],
        ),
      ),
    );
  }
}
