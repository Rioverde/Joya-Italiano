import 'package:Joya_Italiano/Dashboard/usersTile.dart';
import 'package:Joya_Italiano/Models/userData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailedList extends StatefulWidget {
  @override
  _DetailedListState createState() => _DetailedListState();
}

class _DetailedListState extends State<DetailedList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserData>>(context);
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UsersTile(users: users[index]);
      },
    );
  }
}
