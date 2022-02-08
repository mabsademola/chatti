import 'package:chatti/utility.dart/theme.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/material.dart';

String inCaps(String text) {
  text = text[0].toUpperCase() + text.substring(1);

  return text;
}

createChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

Widget buildIcons(
  String assetName, {
  double width = 24,
}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Image.asset(
      'assets/images/icons/$assetName.png',
      width: width,
      color: kPrimaryColor,
    ),
  );
}

Widget buildIconss(
  String assetName, {
  double width = 24,
  VoidCallback onpress,
  Color color = Colors.white70,
}) {
  return InkWell(
    onTap: onpress,
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Image.asset(
          'assets/images/icons/$assetName.png',
          width: width,
          color: color,
        ),
      ),
    ),
  );
}

Widget buttonn({
  String icon,
  VoidCallback onpress,
  String tooltip,
}) {
  return Container(
    padding: const EdgeInsets.all(7),
    child: InkWell(
      onTap: onpress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildIconss(icon),
      ),
    ),
    // IconButton(
    //   color: kPrimaryColor,
    //   icon: icon,
    //   onPressed: onpress,
    //   tooltip: tooltip,
    // ),
    // decoration: BoxDecoration(
    //   color: kPrimaryColor.withOpacity(0.1),
    //   borderRadius: BorderRadius.circular(10),
    // ),
  );
}

String getChatID(String user1, String user2) {
  user1 = user1.substring(0, 7);
  user2 = user2.substring(7, 15);
  List<String> list = [user1, user2];
  list.sort();
  String chatID = '${list[0]}-${list[1]}';
  // cprint(_channelName); //2RhfE-5kyFB
  return chatID;
}

getAge(DateTime dateofbirth) {
  DateTime currentdate = DateTime.now();
  int age = currentdate.year - dateofbirth.year;
  return age;
}

String genderdo(String gen) {
  String gender = gen.toLowerCase();
  return gender == "female"
      ? "her"
      : gender == "male"
          ? "him"
          : "him";
}

String textdo(String name) {
  var len = name.length;
  return len <= 10 ? inCaps(name) : inCaps(name.substring(0, 10)) + "....";
}

Widget entry(String hintText,
    {TextEditingController controller,
    Function validator,
    int maxLine = 1,
    bool isenable = true,
    bool obscureText = false,
    bool offstage = true,
    Function onchanged,
    Function onTap,
    TextInputType inputType}) {
  return Padding(
    padding: !isenable
        ? const EdgeInsets.symmetric(vertical: 4)
        : const EdgeInsets.symmetric(vertical: 8),
    child: TextFormField(
      obscureText: obscureText,
      enabled: isenable,
      controller: controller,
      validator: validator,
      autofocus: false,
      onChanged: onchanged,
      style: kBodyText.copyWith(color: Colors.white),
      keyboardType: inputType,
      textInputAction: TextInputAction.next,
      maxLines: maxLine,
      decoration: InputDecoration(
        suffixIcon: Offstage(
          offstage: offstage,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              color: kContentColorDarkTheme,
              // splashColor: Colors.transparent,
              // highlightColor: Colors.transparent,
              onPressed: onTap,
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                // color: Colors.grey,
              ),
            ),
          ),
        ),
        // contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        hintStyle: kBodyText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
