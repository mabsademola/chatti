import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/material.dart';

class SettingRowWidget extends StatelessWidget {
  const SettingRowWidget(
    this.title, {
    Key key,
    this.navigateTo,
    // this.textColor = Colors.black,
    this.onPressed,
    this.vPadding = 4,
    this.lan = false,
    this.showDivider = true,
    this.icon,
  }) : super(key: key);
  final bool showDivider;
  final bool lan;
  final String navigateTo;
  final String title;
  // final Color textColor;
  final IconData icon;
  final Function onPressed;
  final double vPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding:
              EdgeInsets.symmetric(vertical: vPadding, horizontal: 12),
          onTap: () {
            if (onPressed != null) {
              onPressed();
              return;
            }
            if (navigateTo == null) {
              return;
            }
            Navigator.pushNamed(context, '/$navigateTo');
          },
          leading: Container(
            padding: const EdgeInsets.all(10),
            // height: 25,
            //  width: 50,
            child: Icon(
              icon,
              color: kPrimaryColor,
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          title: title == null
              ? null
              : Text(title ?? '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          trailing: Icon(
            Icons.chevron_right,
            size: 30,
          ),
        ),
        !showDivider ? SizedBox() : Divider(height: 0)
      ],
    );
  }
}
