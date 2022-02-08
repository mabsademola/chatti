import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Chatti",
                  style: kBodyText.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Version 1.0.0"),
                SizedBox(
                  height: 10,
                ),
                Icon(
                  CupertinoIcons.chat_bubble_text_fill,
                  //color: Colors.white,
                  size: 100.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("© 2021 - 2022 Mabs Ademola"),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LicensePage()));
                    },
                    child: Text(
                      "LICENSES",
                      style: kBodyText.copyWith(
                        decoration: TextDecoration.underline,
                        color: Color(0xff33B5E5),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Opacity(
                opacity: 0.4,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "from",
                        style: kBodyText.copyWith(
                          fontStyle: FontStyle.italic,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "MABS ADEMOLA ",
                          style: kBodyText.copyWith(
                            fontStyle: FontStyle.italic,
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
