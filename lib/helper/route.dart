import 'package:chatti/screens/auth/authin.dart';

import 'package:chatti/screens/auth/components/locationdisable.dart';
import 'package:chatti/screens/auth/components/personalinfo.dart';
import 'package:chatti/screens/auth/screens.dart';
import 'package:chatti/screens/Contact/contactlist.dart';
import 'package:chatti/screens/appinfo/appinfo.dart';

import 'package:chatti/screens/screens.dart';
import 'package:flutter/material.dart';

import 'customRoute.dart';

class Routes {
  static dynamic route() {
    return {
      'SplashScreen': (BuildContext context) => SplashScreen(),
    };
  }

  static Route onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name.split('/');
    if (pathElements[0] != '' || pathElements.length == 1) {
      return null;
    }
    switch (pathElements[1]) {
      case "LoginScreen":
        return CustomRoute<bool>(
            builder: (BuildContext context) => LoginScreen());

      case "LoginWithEmail":
        return CustomRoute<bool>(
            builder: (BuildContext context) => LoginWithEmail());
            

      case "ContactList":
        return CustomRoute<bool>(
            builder: (BuildContext context) => ContactList());
      case "PersonalInfo":
        return CustomRoute<bool>(
            builder: (BuildContext context) => PersonalInfo());
      case "Locationdis":
        return CustomRoute<bool>(
            builder: (BuildContext context) => Locationdis());

      case "Forgetpassword":
        return CustomRoute<bool>(
            builder: (BuildContext context) => Forgetpassword());
      case "RegisterWithEmail":
        return CustomRoute<bool>(
            builder: (BuildContext context) => RegisterWithEmail());
      case "Navigation":
        return CustomRoute<bool>(
            builder: (BuildContext context) => Navigation());
      case "AppInfo":
        return CustomRoute<bool>(builder: (BuildContext context) => AppInfo());
      // case "MessagesScreen":
      //   return CustomRoute<bool>(
      //       builder: (BuildContext context) => MessagesScreen());

      default:
        return onUnknownRoute(RouteSettings(name: '/Feature'));
    }
  }

  static Route onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(settings.name.split('/')[1]),
          centerTitle: true,
        ),
        body: Center(
          child: Text('${settings.name.split('/')[1]} Coming soon..'),
        ),
      ),
    );
  }
}
