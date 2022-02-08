import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/material.dart';

//textfield design
class MyTextField extends StatelessWidget {
  const MyTextField({
    Key key,
    @required this.hintText,
    @required this.controller,
    this.maxLine = 1,
    this.isenable = true,
    @required this.inputType,
  }) : super(key: key);
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final int maxLine;
  final bool isenable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        style: kBodyText.copyWith(color: Colors.white),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        maxLines: maxLine,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: kBodyText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}

//textbutton design
class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key key,
    @required this.buttonName,
    @required this.onTap,
  }) : super(key: key);
  final String buttonName;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
            (states) => Colors.black12,
          ),
        ),
        onPressed: onTap,
        child: Text(
          buttonName,
          style: kButtonText.copyWith(color: Colors.black87),
        ),
      ),
    );
  }
}

//textfield_password design
class MyPasswordField extends StatelessWidget {
  const MyPasswordField({
    Key key,
    @required this.isPasswordVisible,
    @required this.controller,
    @required this.onTap,
  }) : super(key: key);

  final bool isPasswordVisible;
  final TextEditingController controller;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        style: kBodyText.copyWith(
          color: Colors.white,
        ),
        obscureText: isPasswordVisible,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: onTap,
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(20),
          hintText: 'Password',
          hintStyle: kBodyText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
