import 'package:Joya_Italiano/Dashboard/detailedList.dart';
import 'package:Joya_Italiano/Database/database.dart';

import 'package:Joya_Italiano/Models/userData.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

final FirebaseMessaging _fm = FirebaseMessaging();

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
    _fm.configure(onMessage: (Map<String, dynamic> message) async {
      print('onMessagee : $message');
    }, onLaunch: (Map<String, dynamic> message) async {
      print('onLaunch : $message');
    }, onResume: (Map<String, dynamic> message) async {
      print('onResume : $message');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
        value: DatabaseService().users,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text("Reservations"),
            ),
            body: DetailedList()));
  }
}
