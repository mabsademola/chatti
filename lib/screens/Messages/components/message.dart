import 'package:chatti/util/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'image_message.dart';
import 'imagetext_message.dart';
import 'text_message.dart';

class Message extends StatelessWidget {
  const Message(
      {Key key,
      @required this.myuserID,
      this.message,
      @required this.imgUrl,
      this.image,
      @required this.messageType,
      @required this.sentBy,
      @required this.isread,
      // @required this.timeSent,
      @required this.isuserID})
      : super(key: key);

  final String myuserID;
  final String message;
  final String imgUrl;
  final bool isread;
  final String image;
  final String messageType;
  final String sentBy;
  // final String timeSent;
  final String isuserID;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    messageContaint() {
      if (messageType == "TEXT") {
        return TextMessage(
          message: message,
          myuserID: myuserID,
          sentBy: sentBy,
        );
      } else if (messageType == "IMAGE") {
        return ImageMessage(
          image: image,
          myuserID: myuserID,
          sentBy: sentBy,
        );
      } else if (messageType == "IMAGETEXT") {
        return ImageTextMessage(
          message: message,
          image: image,
          myuserID: myuserID,
          sentBy: sentBy,
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        //  MediaQuery.of(context).size.width * 0.60,
        mainAxisAlignment: sentBy == myuserID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          sentBy == myuserID
              ? SizedBox(
                  width: size * 0.10,
                )
              : Container(),
          if (sentBy != myuserID) ...[
            ProfileAvatar(imageUrl: imgUrl, radius: 12),
            SizedBox(width: kDefaultPadding / 2),
          ],
          Flexible(child: messageContaint()),
          if (sentBy == myuserID) MessageStatusDot(status: isread),
          sentBy != myuserID
              ? SizedBox(
                  width: size * 0.15,
                )
              : Container(),
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final bool status;

  const MessageStatusDot({Key key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 2),
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: status
            ? kPrimaryColor
            : Theme.of(context).textTheme.bodyText1.color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status ? Icons.check : Icons.done,
        size: 10,
        color:
            status ? kPrimaryColor : Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
