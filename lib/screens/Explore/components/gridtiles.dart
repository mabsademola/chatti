// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:chatti/models/user_model.dart';
// import 'package:chatti/util/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';

// import '../../pro.dart';

// class GridTiles extends StatelessWidget {
//   const GridTiles({
//     Key key,
//     @required this.ds,
//   }) : super(key: key);

//   final UserModel ds;

//   @override
//   Widget build( BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => ProfileScreen()));
//         },
//         child: Container(
//           // width: 100,
//           // height: 100,
//           child: Stack(
//             // fit :StackFit.expand,
//             children: [
//               // Positioned(
//               //   bottom: 0,
//               //   child: Row(
//               //     children: [
//               //       Expanded(
//               //           child: Column(children: [
//               //         Text(
//               //          inCaps(ds["displayName"]),
//               //         ),
//               //         Text("2 km away")
//               //       ])),
//               //       Text("25"),
//               //     ],
//               //   ),
//               // ),

//               Positioned(
//                   right: 0,
//                   top: 0,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 3),
//                       height: 25,
//                       // width: 50,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             LineAwesomeIcons.venus,
//                             color: Colors.white,
//                             size: 15,
//                           ),
//                           Text(
//                             "2 km",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w700),
//                           ),
//                         ],
//                       ),
//                       decoration: BoxDecoration(
//                         boxShadow: <BoxShadow>[
//                           BoxShadow(
//                             blurRadius: 10,
//                             offset: Offset(5, 5),
//                           ),
//                         ],
//                         color: kPrimaryColor,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   )),
//               Positioned(
//                   right: 0,
//                   bottom: 0,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 3),
//                       height: 25,
//                       width: 25,
//                       child: Center(
//                         child: Text(
//                           "28",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w700),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         boxShadow: <BoxShadow>[
//                           BoxShadow(
//                             blurRadius: 10,
//                             offset: Offset(5, 5),
//                           ),
//                         ],
//                         color: kPrimaryColor,
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                     ),
//                   )),
//             ],
//           ),
//           decoration: BoxDecoration(
//               boxShadow: <BoxShadow>[
//                 BoxShadow(
//                   // color: Color(0xffeeeeee),
//                   blurRadius: 10,
//                   offset: Offset(2, 2),
//                 ),
//               ],

//               // color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               image: DecorationImage(
//                   image: CachedNetworkImageProvider(
//                     ds.profilePic,
//                   ),
//                   fit: BoxFit.cover)),
//         ),
//       ),
//     );
//   }
// }
