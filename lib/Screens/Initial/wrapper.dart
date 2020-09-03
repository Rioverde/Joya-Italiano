import 'package:Joya_Italiano/Dashboard/dashboard.dart';
import 'package:Joya_Italiano/Models/user.dart';
import 'package:Joya_Italiano/Screens/choise.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Choise();
    } else {
      return CustomerDashboard();
    }
  }
}
