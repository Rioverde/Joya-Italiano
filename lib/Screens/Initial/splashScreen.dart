import 'package:Joya_Italiano/Screens/Initial/wrapper.dart';
import 'package:Joya_Italiano/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    firebaseMessaging.getToken().then((token) {
      print('FCM Token: $token');
    });
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Wrapper()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Image(image: logo),
            ),
          ),
          Expanded(
            flex: 1,
            child: SpinKitFadingCube(
              duration: Duration(seconds: 1),
              color: Colors.white,
              size: 40.0,
            ),
          )
        ],
      ),
    );
  }
}
