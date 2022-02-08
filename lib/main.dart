
import 'package:chatti/provider/nav_provider.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'helper/route.dart';
import 'provider/auth_provider.dart';
import 'provider/chat_provider.dart';
import 'provider/getdata_provider.dart';
import 'provider/location_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await availableCameras();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<GetDataProvider>(
              create: (_) => GetDataProvider()),
          ChangeNotifierProvider<LocationProvider>(
              create: (_) => LocationProvider()),
          ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
          ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
          ChangeNotifierProvider<NavProvider>(create: (_) => NavProvider()),
        ],
        child: MaterialApp(
          title: 'Chatti',
          debugShowCheckedModeBanner: false,
          theme: themeData(context),
          routes: Routes.route(),
          onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
          onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
          initialRoute: "SplashScreen",
        ));
  }
}
