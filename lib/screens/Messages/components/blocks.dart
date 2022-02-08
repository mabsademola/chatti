import 'package:chatti/Widgets/Enum.dart';
import 'package:chatti/extensions/text_extension.dart';
import 'package:chatti/models/user_model.dart';
import 'package:chatti/provider/chat_provider.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chat_input_field.dart';

class ChatInputWidget extends StatelessWidget {
  ChatInputWidget({
    Key key,
    // @required this.chatState,
    @required this.userdata,
    @required this.blockStates,
    @required this.myuserId,
    @required this.sendapology,
     @required this.unblock,

  }) : super(key: key);

  // ChatProvider chatState;
  final UserModel userdata;
  final BlockStates blockStates;
  final String myuserId;
    final VoidCallback sendapology;
     final VoidCallback unblock;
    
  
  @override
  Widget build(BuildContext context) {
    Widget chatInputWidget(BlockStates blockStates) {
      switch (blockStates) {
        case BlockStates.apologies:
          return Apology(
            userdata: userdata,
            blockStates: blockStates,
          );

        case BlockStates.blockbyme:
          return Byme(
            userdata: userdata, blockStates: blockStates, unblockuser: unblock,
            // chatState: chatState,
          );
        case BlockStates.blockbyuser:
          return Byuser(
            userdata: userdata,
             sendapology: sendapology,
          );
        default:
          return ChatInputField(
            myuserID: myuserId,
            isuserID: userdata.userId,
          );
      }
    }

    return chatInputWidget(blockStates);
  }
}

class Apology extends StatelessWidget {
  Apology({
    Key key,
    // @required this.chatState,
    @required this.userdata,
    @required this.blockStates,
  }) : super(key: key);

  // ChatProvider chatState;
  final UserModel userdata;
  final BlockStates blockStates;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(40),
        ),
        // padding: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: kDefaultPadding / 1,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Apology already sent to ${textdo(userdata.displayName)}"),
            SizedBox(width: 5),
          ],
        ));
  }
}

class Byme extends StatelessWidget {
  const Byme({
    Key key,
    @required this.userdata,
    @required this.blockStates,
      @required this.unblockuser,
  }) : super(key: key);

  // final ChatProvider chatState;
  final UserModel userdata;
  final BlockStates blockStates;
    final VoidCallback unblockuser;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(40),
        ),
        // padding: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: kDefaultPadding / 1,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You blocked ${textdo(userdata.displayName)}"),
            SizedBox(width: 5),
            GestureDetector(
              onTap: unblockuser,
              child: Text("Tap To Unblock",
                  style: TextStyle(
                    color: kPrimaryColor,
                  )),
            ),
          ],
        ));
  }
}

class Byuser extends StatelessWidget {
  const Byuser({
    Key key,
    // @required this.chatState,
    @required this.userdata,
    @required this.blockStates,
    @required this.sendapology,
  }) : super(key: key);

  // final ChatProvider chatState;
  final UserModel userdata;
  final BlockStates blockStates;
  final VoidCallback sendapology;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(40),
      ),
      // padding: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: kDefaultPadding / 1,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("You been blocked by ${textdo(userdata.displayName)}"),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              sendapology();
            },
            child: Text("apologies",
                style: TextStyle(
                  color: kPrimaryColor,
                )),
          ),
        ],
      ),
    );
  }
}
