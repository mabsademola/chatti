// import 'package:chatti/models/chat_model.dart';
// import 'package:chatti/util/theme.dart';
// import 'package:flutter/material.dart';

// import 'chat_input_field.dart';
// import 'message.dart';

// class Body extends StatelessWidget {
//   const Body({
//     Key key,
//     // @required this.message,
//     @required this.imgUrl,
//     @required this.myUserId,
//   }) : super(key: key);

//   // final ChatMessage message;
//   final String imgUrl;
//   final String myUserId;

//   @override
//   Widget build( BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
//             child: ListView.builder(
//               itemCount: demeChatMessages.length,
//               itemBuilder: (context, index) => Message(
//                 message: demeChatMessages[index],
//                 imgUrl: imgUrl,
//               ),
//             ),
//           ),
//         ),
//         ChatInputField(),
//       ],
//     );
//   }
// }
