import 'package:chatti/screens/Profile/components/headerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'Component/reporttiles.dart';

class Report extends StatefulWidget {
  const Report({Key key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Report"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          HeaderWidget(
            'Please select a problem',
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "If someone is in immediate danger, get help before reporting to Chatting. Don't wait",
              // style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          ReportRowWidget(
            "Pretending in Be Someone",
            onPressed: () {
              GFToast.showToast(
                  "User has been reported for pretending to be someone else",
                  context,
                  toastPosition: GFToastPosition.BOTTOM,
                  textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
                  backgroundColor: GFColors.LIGHT,
                  trailing: Icon(
                    CupertinoIcons.flag_circle_fill,
                    color: GFColors.DANGER,
                  ));
              Navigator.pop(context);
            },

            // navigateTo: 'DisplayAndSoundPage'
          ),
          ReportRowWidget(
            "Spam or Advertiser",
            onPressed: () {
              GFToast.showToast("User has been reported for spamming", context,
                  toastPosition: GFToastPosition.BOTTOM,
                  textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
                  backgroundColor: GFColors.LIGHT,
                  trailing: Icon(
                    CupertinoIcons.flag_circle_fill,
                    color: GFColors.DANGER,
                  ));
              Navigator.pop(context);
            },
          ),
          ReportRowWidget(
            "Fraud",
            onPressed: () {
              GFToast.showToast(
                  "User has been reported for fraudulent activity", context,
                  toastPosition: GFToastPosition.BOTTOM,
                  textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
                  backgroundColor: GFColors.LIGHT,
                  trailing: Icon(
                    CupertinoIcons.flag_circle_fill,
                    color: GFColors.DANGER,
                  ));
              Navigator.pop(context);
            },
          ),
          ReportRowWidget(
            "Harassment or Bullying",
            onPressed: () {
              GFToast.showToast(
                  "User has been reported for harassment and bullying", context,
                  toastPosition: GFToastPosition.BOTTOM,
                  textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
                  backgroundColor: GFColors.LIGHT,
                  trailing: Icon(
                    CupertinoIcons.flag_circle_fill,
                    color: GFColors.DANGER,
                  ));
              Navigator.pop(context);
            },
          ),
          ReportRowWidget(
            "Something Else",
            onPressed: () {
              GFToast.showToast("User has been reported", context,
                  toastPosition: GFToastPosition.BOTTOM,
                  textStyle: TextStyle(fontSize: 13, color: GFColors.DARK),
                  backgroundColor: GFColors.LIGHT,
                  trailing: Icon(
                    CupertinoIcons.flag_circle_fill,
                    color: GFColors.DANGER,
                  ));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
