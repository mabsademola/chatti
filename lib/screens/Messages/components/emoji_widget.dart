import 'dart:io';

import 'package:chatti/utility.dart/theme.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class EmojiWidget extends StatelessWidget {
  final Function onEmojiSelected;
  final Function onBackspacePressed;

  const EmojiWidget(
      {Key key,
      @required this.onEmojiSelected,
      @required this.onBackspacePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
        onEmojiSelected: onEmojiSelected,
        onBackspacePressed: onBackspacePressed,
        config: Config(
          columns: 7,

          emojiSizeMax: 32,
          //  * (Platform.isIOS ? 1.30 : 1.0),
          verticalSpacing: 0,
          horizontalSpacing: 0,
          initCategory: Category.RECENT,
          bgColor: kContentColorLightTheme,
          indicatorColor: kPrimaryColor.withOpacity(0.6),
          iconColor: Colors.white.withOpacity(0.7),
          iconColorSelected: kPrimaryColor,
          progressIndicatorColor: kPrimaryColor,
          backspaceColor: kPrimaryColor,
          showRecentsTab: true,
          recentsLimit: 28,
          noRecentsText: 'No Recents',
          noRecentsStyle: const TextStyle(fontSize: 20, color: Colors.white70),
          tabIndicatorAnimDuration: kRadialReactionDuration,
          categoryIcons: const CategoryIcons(),
          // buttonMode: ButtonMode.CUPERTINO),
        ));
  }
}
