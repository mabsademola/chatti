import 'package:chatti/extensions/text_extension.dart';
import 'package:chatti/provider/auth_provider.dart';

import 'package:chatti/utility.dart/theme.dart';
import 'package:chatti/util/loadings.dart';
import 'package:chatti/Widgets/text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:provider/provider.dart';

import 'authin.dart';

class Forgetpassword extends StatefulWidget {
  @override
  _ForgetpasswordState createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  TextEditingController emailtextcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CustomLoader loader;

  void _submitForm() {
    var state = Provider.of<AuthProvider>(context, listen: false);

    state.forgetPassword(
      emailtextcontroller.text,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            width: 24,
            color: Colors.white70,
            image: Svg('assets/images/back_arrow.svg'),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Forget password",
                            style: kHeadline,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Please enter email address. You will receive link to create a new password.",
                            style: kBodyText2,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Form(
                            key: _formKey,
                            child: entry('Email',
                                inputType: TextInputType.emailAddress,
                                controller: emailtextcontroller,
                                validator: (value) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)
                                  ? null
                                  : "Enter a correct email";
                            }),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Remebered your password ? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => LoginWithEmail(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign In',
                            style: kBodyText.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                      buttonName: 'RESET PASSWORD',
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          _submitForm();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
