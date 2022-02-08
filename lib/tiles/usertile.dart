import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatti/extensions/text_extension.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserlistTile extends StatelessWidget {
  const UserlistTile({
    Key key,
    this.name,
    @required this.press,
    this.imgUrl,
    this.about,
    this.username,
    this.email,
  }) : super(key: key);

  // final UserData userData;
  final VoidCallback press;
  final String name, imgUrl, about, username, email;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kkDefaultPadding * 0.75),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Hero(
                      tag: name,
                      child: CachedNetworkImage(
                        height: 50,
                        width: 50,
                        imageUrl: imgUrl,
                        placeholder: (context, url) => Container(
                          child: FaIcon(FontAwesomeIcons.user),
                        ),
                        errorWidget: (context, url, error) => Container(
                          child: FaIcon(FontAwesomeIcons.user),
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
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
                        inCaps(name),
                        // name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 8),
                      Opacity(
                        opacity: 0.64,
                        child: Text(
                          about,
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
      ),
    );
  }
}
