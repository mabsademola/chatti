// ignore_for_file: prefer_conditional_assignment

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  const CircularImage(
      {Key key, this.path, this.height = 50, this.isBorder = false})
      : super(key: key);
  final String path;
  final double height;
  final bool isBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
            Border.all(color: Colors.grey.shade100, width: isBorder ? 2 : 0),
      ),
      child: CircleAvatar(
        maxRadius: height / 2,
        backgroundColor: Theme.of(context).cardColor,
        backgroundImage: customAdvanceNetworkImage(path ?? maleimg),
      ),
    );
  }
}

CachedNetworkImageProvider customAdvanceNetworkImage(String path) {
  if (path == null) {
    path = maleimg;
  }
  return CachedNetworkImageProvider(
    path ?? maleimg,
  );
}

//  Widget build( BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.all(
//                   Radius.circular(10.0),
//                 ),
//       child: Container(
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border:
//               Border.all(color: Colors.grey.shade100, width: isBorder ? 2 : 0),
//         ),
//         child: Hero(
//           tag: path,
//           child: CachedNetworkImage(
//             imageUrl: path,
//             placeholder: (context, url) => Container(
//               height: height,
//               width: height,
//               child: Image.asset(
//                 gender == "Male"
//                     ? 'assets/images/pro/img_default_avatar_man.png'
//                     : 'img_default_avatar_woman.png',
//                 fit: BoxFit.cover,
//                 height: height,
//                 width: height,
//               ),
//             ),
//             errorWidget: (context, url, error) => Image.asset(
//               gender == "Male"
//                   ? 'assets/images/pro/img_default_avatar_man.png'
//                   : 'img_default_avatar_woman.png',
//               fit: BoxFit.cover,
//               height: height,
//               width: height,
//             ),
//             fit: BoxFit.cover,
//             height: height,
//             width: height,
//           ),
//         ),

//         //  CircleAvatar(
//         //   maxRadius: height / 2,
//         //   backgroundColor: Theme.of(context).cardColor,
//         //   backgroundImage:
//         //       customAdvanceNetworkImage(path ?? Constants.dummyProfilePic),
//         // ),
//       ),
//     );
//   }
// }


