import 'package:flutter/material.dart';

class Chat {
  final String name, lastMessage, image, time;
  final bool isActive;

  Chat({
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
  });
}

List chatsData = [
  Chat(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "assets/images/user.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "assets/images/user_2.png",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "assets/images/user_3.png",
    time: "5d ago",
    isActive: false,
  ),
  Chat(
    name: "Jacob Jones",
    lastMessage: "You’re welcome :)",
    image: "assets/images/user_4.png",
    time: "5d ago",
    isActive: true,
  ),
  Chat(
    name: "Albert Flores",
    lastMessage: "Thanks",
    image: "assets/images/user_5.png",
    time: "6d ago",
    isActive: false,
  ),
  Chat(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "assets/images/user.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "assets/images/user_2.png",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "assets/images/user_3.png",
    time: "5d ago",
    isActive: false,
  ),
];

enum messageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

// class ChatMessage {
//   final String text;
//   final ChatMessageType messageType;
//   final MessageStatus messageStatus;
//   final bool isSender;

//   ChatMessage({
//     this.text = '',
//     @required this.messageType,
//     @required this.messageStatus,
//     @required this.isSender,
//   });
// }

// List demeChatMessages = [
//   ChatMessage(
//     text: "Hi Sajol,",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Hello, How are you?",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "",
//     messageType: ChatMessageType.audio,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "",
//     messageType: ChatMessageType.video,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "Error happend",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_sent,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "This looks great man!!",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Glad you like it",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_view,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "Hi Sajol,",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Hello, How are you?",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "",
//     messageType: ChatMessageType.audio,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "",
//     messageType: ChatMessageType.video,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Error happend",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_sent,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "This looks great man!!",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Glad you like it",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_view,
//     isSender: true,
//   ),
// ];
