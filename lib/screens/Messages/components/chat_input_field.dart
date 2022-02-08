import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:chatti/extensions/text_extension.dart';

import 'package:chatti/services/database.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chatti/utility.dart/theme.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'emoji_widget.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({
    Key key,
    @required this.myuserID,
    @required this.isuserID,
  }) : super(key: key);

  final String myuserID;
  final String isuserID;

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  TextEditingController _controller = TextEditingController();

  bool sendButton = false;
  bool imgButton = false;
  FocusNode _focusNode;
  bool emojiShowing = false;
  final _picker = ImagePicker();

  bool isSending = false;
  bool isimg = false;
  bool sendimg = false;
  File imageFile;

  Future _pickImage(ImageSource imageSource) async {
    final pickedFile = await _picker.getImage(
      source: imageSource,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      final croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio7x5,
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Select an Image',
          toolbarColor: Theme.of(context).colorScheme.secondary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          activeControlsWidgetColor: Theme.of(context).primaryColor,
        ),
        iosUiSettings:
            IOSUiSettings(title: 'Select an Image', doneButtonTitle: 'Done'),
      );
      return croppedFile != null ? croppedFile : null;
    }
  }

  void _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
    // if (_controller.text.isNotEmpty) {
    //   setState(() {
    //     sendButton = true;
    //   });
    // } else {
    //   setState(() {
    //     sendButton = false;
    //   });
    // }
  }

  void _onEmojiButtonPressed() {
    if (emojiShowing) {
      _focusNode.requestFocus();
      emojiShowing = false;
    } else {
      _focusNode.unfocus();
      emojiShowing = true;
    }
    setState(() {});
  }

  void _onEmojiSelected(emoji) {
    _controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));

    if (_controller.text.isNotEmpty) {
      sendButton = true;
    } else {
      sendButton = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    imageFile = null;
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isSending) LinearProgressIndicator(),
        if (!isSending && imageFile != null)
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: 80.0,
                    width: 80.0,
                    margin: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2,
                    ),
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: kDefaultPadding / 2,
                    //   vertical: kDefaultPadding / 2,
                    // ),

                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(ThemeConfig.borderRadius),
                    // ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.file(
                        imageFile,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    top: -3,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            imageFile = null;
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        // height: 30,
                        // width: 30,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  )

                  //        IconButton(
                  //   icon: Icon(Icons.close),
                  //   onPressed: () {
                  //     setState(
                  //       () {
                  //         imageFile = null;
                  //       },
                  //     );
                  //   },
                  // ))
                ],
              ),
            ],
          ),
        WillPopScope(
          onWillPop: () {
            if (emojiShowing) {
              emojiShowing = false;
              setState(() {});
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 32,
                  color: Color(0xFF087949).withOpacity(0.08),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: kDefaultPadding / 2,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 0.50,
                          ),
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              !emojiShowing
                                  ? buildIconss(
                                      "photo_sticker",
                                      onpress: () {
                                        _onEmojiButtonPressed();
                                      },
                                      // tooltip: "Tap to cancel request"
                                    )
                                  : InkWell(
                                      onTap: () {
                                        _onEmojiButtonPressed();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(CupertinoIcons.keyboard,
                                            color: Colors.white70),
                                      ),
                                    ),

                              // GestureDetector(
                              //   onTap: () {
                              //     _onEmojiButtonPressed();
                              //   },
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Icon(
                              //         emojiShowing
                              //             ? CupertinoIcons.keyboard
                              //             :
                              //             // buildIconss("photo_sticker"),
                              //             CupertinoIcons.smiley,
                              //         color: Colors.white70),
                              //   ),
                              // ),

                              // SizedBox(width: kDefaultPadding / 3),
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  focusNode: _focusNode,
                                  keyboardType: TextInputType.multiline,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  autofocus: false,
                                  maxLines: 5,
                                  minLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        sendButton = true;
                                      });
                                    } else {
                                      setState(() {
                                        sendButton = false;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Type message",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Offstage(
                                offstage: sendButton,
                                child: Row(
                                  children: [
                                    buildIconss(
                                      "input_video_pressed",
                                      onpress: () {
                                        _pickImage(ImageSource.gallery)
                                            .then((image) {
                                          if (image != null) {
                                            sendButton = true;
                                            isimg = true;
                                            imageFile = image;
                                            setState(() {});
                                          }
                                        });
                                      },
                                      // tooltip: "Tap to cancel request"
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     _pickImage(ImageSource.gallery)
                                    //         .then((image) {
                                    //       if (image != null) {
                                    //         sendButton = true;
                                    //         setState(() {
                                    //           imageFile = image;
                                    //         });
                                    //       }
                                    //     });
                                    //     // ImageController.instance
                                    //     //     .cropImageFromFile(
                                    //     //         ImageSource.gallery, context)
                                    //     //     .then((image) {
                                    //     //
                                    //
                                    // (image != null) {
                                    //     //     sendButton = true;
                                    //     //     setState(() {
                                    //     //       imageFile = image;
                                    //     //     });
                                    //     //   }
                                    //     // });
                                    //   },
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(8.0),
                                    //     child: Icon(Icons.attach_file,
                                    //         color: Colors.white70),
                                    //   ),
                                    // ),

                                    InkWell(
                                      onTap: () {
                                        _pickImage(ImageSource.camera)
                                            .then((image) {
                                          if (image != null) {
                                            sendButton = true;
                                            isimg = true;
                                            setState(() {
                                              imageFile = image;
                                            });
                                          }
                                        });
                                        // ImageController.instance
                                        //     .cropImageFromFile(
                                        //         ImageSource.camera, context)
                                        //     .then((image) {
                                        //   if (image != null) {
                                        //     sendButton = true;
                                        //     setState(() {
                                        //       imageFile = image;
                                        //     });
                                        //   }
                                        // });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(CupertinoIcons.camera_fill,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: kDefaultPadding / 2),
                      CircleAvatar(
                          backgroundColor: kPrimaryColor.withOpacity(0.1),
                          radius: 25,
                          child: sendimg
                              ? IconButton(
                                  icon: Icon(
                                    Icons.block,
                                    color: kPrimaryColor,
                                  ),
                                  onPressed: null,
                                )
                              : sendButton
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.send,
                                        color: kPrimaryColor,
                                      ),
                                      onPressed: onpress,
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.mic,
                                        color: kPrimaryColor,
                                      ),
                                      onPressed: () {
                                        GFToast.showToast(
                                            "This feature is currently disabled",
                                            context,
                                            toastPosition:
                                                GFToastPosition.BOTTOM,
                                            textStyle: TextStyle(
                                                fontSize: 13,
                                                color: GFColors.DARK),
                                            backgroundColor: GFColors.LIGHT,
                                            trailing: Icon(
                                              CupertinoIcons
                                                  .exclamationmark_circle_fill,
                                              color: GFColors.INFO,
                                            ));
                                      },
                                    )),
                    ],
                  ),
                ),
                Offstage(
                  offstage: !emojiShowing,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: EmojiWidget(
                      onBackspacePressed: _onBackspacePressed,
                      onEmojiSelected: (Category category, Emoji emoji) {
                        sendButton = true;
                        _onEmojiSelected(emoji);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> onpress() async {
    if (sendButton) {
      String message = _controller.text;
      var time = DateTime.now().millisecondsSinceEpoch;

      if (_controller.text != "" && imageFile == null) {
        _resetTextFieldAndLoading();

        try {
          sendimg = true;
          setState(() {});
          Map<String, dynamic> messageInfo = {
            "text": message,
            "messageType": "TEXT",
            "sentBy": widget.myuserID,
            "timeSent": time,
            "isread": false,
          };

          await DatabaseMethods(
            uid: widget.myuserID,
          ).sendMessage(
            isuserID: widget.isuserID,
            messageInfo: messageInfo,
          );
          await DatabaseMethods(
            uid: widget.isuserID,
          ).sendMessage(
            isuserID: widget.myuserID,
            messageInfo: messageInfo,
          );
          await DatabaseMethods().updateUserChatListField(
            documentID: widget.isuserID,
            messageType: "TEXT",
            chatID: widget.myuserID,
            lastMessage: message,
            myuserId: widget.myuserID,
            selectedUserID: widget.myuserID,
          );
          await DatabaseMethods().updateUserChatListField(
            documentID: widget.myuserID,
            messageType: "TEXT",
            chatID: widget.isuserID,
            lastMessage: message,
            myuserId: widget.myuserID,
            selectedUserID: widget.isuserID,
          );

          _getUnreadMSGCountThenSendMessage();

          imageFile = null;
          sendimg = false;
          setState(() {});
        } catch (e) {
          sendimg = false;
          setState(() {});
          print(e);
        }
      }

      if (imageFile != null && _controller.text == "") {
        _resetTextFieldAndLoading();

        try {
          sendimg = true;
          setState(() {});
          Reference uploadimg = FirebaseStorage.instance
              .ref("Messages/img/")
              .child(imageFile.path);

          UploadTask uploadTask = uploadimg.putFile(imageFile);

          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
          var imageurl = (await taskSnapshot.ref.getDownloadURL()).toString();
          print(imageurl);
          Map<String, dynamic> messageInfo = {
            "image": imageurl,
            "messageType": "IMAGE",
            "sentBy": widget.myuserID,
            "timeSent": time,
            "isread": false,
          };
          await DatabaseMethods(
            uid: widget.myuserID,
          ).sendMessage(
            isuserID: widget.isuserID,
            messageInfo: messageInfo,
          );
          await DatabaseMethods(
            uid: widget.isuserID,
          ).sendMessage(
            isuserID: widget.myuserID,
            messageInfo: messageInfo,
          );

          await DatabaseMethods().updateUserChatListField(
            documentID: widget.isuserID,
            messageType: "IMAGE",
            chatID: widget.myuserID,
            lastMessage: "Sent a photo",
            myuserId: widget.myuserID,
            selectedUserID: widget.myuserID,
          );

          await DatabaseMethods().updateUserChatListField(
            documentID: widget.myuserID,
            messageType: "IMAGE",
            chatID: widget.isuserID,
            lastMessage: "Sent a photo",
            myuserId: widget.myuserID,
            selectedUserID: widget.isuserID,
          );

          imageFile = null;
          sendimg = false;
          setState(() {});

          print("done sending");
        } catch (e) {
          sendimg = false;
          setState(() {});
          print(e);
        }
      }

      if (imageFile != null && _controller.text != "") {
        _resetTextFieldAndLoading();
        try {
          sendimg = true;
          setState(() {});
          Reference uploadimg = FirebaseStorage.instance
              .ref("Messages/img/")
              .child(imageFile.path);

          UploadTask uploadTask = uploadimg.putFile(imageFile);
          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
          var imageurl = (await taskSnapshot.ref.getDownloadURL()).toString();
          print(imageurl);
          Map<String, dynamic> messageInfo = {
            "text": message,
            "image": imageurl,
            "messageType": "IMAGETEXT",
            "sentBy": widget.myuserID,
            "timeSent": time,
            "isread": false,
          };

          await DatabaseMethods(
            uid: widget.myuserID,
          ).sendMessage(
            isuserID: widget.isuserID,
            messageInfo: messageInfo,
          );
          await DatabaseMethods(
            uid: widget.isuserID,
          ).sendMessage(
            isuserID: widget.myuserID,
            messageInfo: messageInfo,
          );

          await DatabaseMethods().updateUserChatListField(
            documentID: widget.isuserID,
            messageType: "IMAGETEXT",
            chatID: widget.myuserID,
            lastMessage: message,
            myuserId: widget.myuserID,
            selectedUserID: widget.myuserID,
          );

          await DatabaseMethods().updateUserChatListField(
            documentID: widget.myuserID,
            messageType: "IMAGETEXT",
            chatID: widget.isuserID,
            lastMessage: message,
            myuserId: widget.myuserID,
            selectedUserID: widget.isuserID,
          );

          _getUnreadMSGCountThenSendMessage();
          imageFile = null;

          print("done sending");
          sendimg = false;
          setState(() {});
        } catch (e) {
          sendimg = false;
          setState(() {});
          print(e);
        }
      }

      setState(() {
        sendimg = false;
        sendButton = false;
        isimg = false;
        imageFile = null;
      });
    }
  }

  Future<void> _getUnreadMSGCountThenSendMessage() async {
    try {
      int unReadMSGCount =
          await DatabaseMethods().getUnreadMSGCount(widget.isuserID);
      print(unReadMSGCount);
      // await NotificationController.instance.sendNotificationMessageToPeerUser(unReadMSGCount, messageType, _msgTextController.text, widget.myName, widget.chatID, widget.selectedUserToken,widget.myImageUrl);
    } catch (e) {
      print(e.message);
    }
  }

  void _resetTextFieldAndLoading() {
    // FocusScope.of(context).requestFocus(FocusNode());
    _controller.text = '';
  }
}
