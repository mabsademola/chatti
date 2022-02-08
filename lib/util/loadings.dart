// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class CustomLoader {
//   static CustomLoader _customLoader;

//   // CustomLoader._createObject();

//   // factory CustomLoader() {
//   //   if (_customLoader != null) {
//   //     return _customLoader;
//   //   } else {
//   //     _customLoader = CustomLoader._createObject();
//   //     return _customLoader;
//   //   }
//   // }

//   //static OverlayEntry _overlayEntry;
//   OverlayState _overlayState; //= new OverlayState();
//   OverlayEntry _overlayEntry;

//   void _buildLoader({
//     String message,
//     // Stream<String> progress
//   }) {
//     _overlayEntry = OverlayEntry(
//       opaque: true,
//       builder: (context) {
//         return Container(
//             height: 500,
//             width: 200,
//             child: buildLoader(context, message: "me ni"
//                 //  message,
//                 // backgroundColor: Colors.transparent,
//                 //  progress: progress
//                 ));
//       },
//     );
//   }

//   void showLoader(BuildContext context,
//       {String message, Stream<String> progress}) {
//     _overlayState = Overlay.of(context);
//     _buildLoader(
//       message: message,
//       // progress: progress
//     );
//     _overlayState.insert(_overlayEntry);
//   }

//   hideLoader() {
//     try {
//       _overlayEntry?.remove();
//       _overlayEntry = null;
//     } catch (e) {
//       print("Exception:: $e");
//     }
//   }

//   buildLoader(
//     BuildContext context, {
//     Color backgroundColor,
//     String message,
//     //  Stream<String> progress
//   }) {
//     var height = 150.0;
//     return Scaffold(
//       body: _CustomScreenLoader(
//           height: height,
//           width: height,
//           backgroundColor: backgroundColor,
//           message: message,
//           // progress: progress,
//           onTap: () {
//             // hideLoader();
//           }),
//     );
//   }
// }

// class _CustomScreenLoader extends StatelessWidget {
//   final Color backgroundColor;
//   final double height;
//   final double width;
//   final VoidCallback onTap;
//   final String message;
//   // final Stream<String> progress;
//   const _CustomScreenLoader({
//     Key key,
//     this.backgroundColor = const Color(0xfff8f8f8),
//     this.height = 40,
//     this.width = 40,
//     this.onTap,
//     this.message,
//     // this.progress,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         // color: backgroundColor,
//         alignment: Alignment.center,
//         child: Container(
//           // height: height,
//           // width: height,
//           // alignment: Alignment.center,
//           child: Container(
//             height: height,
//             width: height,
//             // padding: EdgeInsets.all(30),
//             decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.all(Radius.circular(10))),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: height - 70,
//                   width: height - 80,
//                   child: Stack(
//                     fit: StackFit.expand,
//                     alignment: Alignment.center,
//                     children: <Widget>[
//                       const CircularProgressIndicator.adaptive(strokeWidth: 2),
//                       Center(
//                           // child: Image.asset(
//                           //   Images.twitterLogo,
//                           //   height: 40,
//                           //   width: 40,
//                           //   fit: BoxFit.fitHeight,
//                           // ),
//                           )
//                     ],
//                   ),
//                 ),
//                 if (message != null)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Center(
//                         child: Text(
//                           message,
//                           style: TextStyle(fontSize: 15),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       )
//                     ],
//                   )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors

import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoader {
  static CustomLoader _customLoader;

  CustomLoader._createObject();

  factory CustomLoader() {
    if (_customLoader != null) {
      return _customLoader;
    } else {
      _customLoader = CustomLoader._createObject();
      return _customLoader;
    }
  }

  //static OverlayEntry _overlayEntry;
  OverlayState _overlayState; //= new OverlayState();
  OverlayEntry _overlayEntry;

  _buildLoader() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        var size = MediaQuery.of(context).size;
        return Container(
            height: size.height,
            width: size.width,
            child: buildLoader(context));
      },
    );
  }

  showLoader(context) {
    _overlayState = Overlay.of(context);
    _buildLoader();
    _overlayState.insert(_overlayEntry);
  }

  hideLoader() {
    try {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } catch (e) {
      print("Exception:: $e");
    }
  }

  buildLoader(BuildContext context, {Color backgroundColor}) {
    if (backgroundColor == null) {
      backgroundColor = const Color(0xffa8a8a8).withOpacity(.5);
    }
    var height = 150.0;
    return CustomScreenLoader(
      height: height,
      width: height,
      backgroundColor: backgroundColor,
    );
  }
}

class CustomScreenLoader extends StatelessWidget {
  final Color backgroundColor;
  final double height;
  final double width;
  const CustomScreenLoader(
      {Key key,
      this.backgroundColor = const Color(0xfff8f8f8),
      this.height = 200,
      this.width = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Container(
        height: height,
        width: height,
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.all(40),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                  Icon(
                    CupertinoIcons.chat_bubble_text_fill,
                    color: kPrimaryColor.withOpacity(0.7),
                    // size: 40.0,
                  ),
                  // GFLoader(
                  //   androidLoaderColor:
                  //       AlwaysStoppedAnimation<Color>(kPrimaryColor),
                  //   loaderstrokeWidth: 2,
                  //   size: 100,
                  // ),
                  // GFLoader(
                  //   type: GFLoaderType.custom,
                  //   loaderIconOne: Icon(
                  //     CupertinoIcons.chat_bubble_text_fill,
                  //     color: kPrimaryColor.withOpacity(0.7),
                  //     size: 40.0,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Please Wait",
                style: TextStyle(
                  color: kPrimaryColor.withOpacity(0.7),
                  fontSize: 15,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
