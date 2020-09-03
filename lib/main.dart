import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/user.dart';
import 'Services/AuthServices.dart';
import 'Screens/Initial/splashScreen.dart';
import 'theme.dart';

void main() {
  runApp(Joya());
}

ImageProvider logo = AssetImage("assets/main.png");

class Joya extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/main.png"), context);

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: joyaTheme(),
        home: SplashScreen(),
        // When navigating to the "/" route, build the FirstScreen widget.
      ),
    );
  }
}
