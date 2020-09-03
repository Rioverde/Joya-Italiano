import 'dart:math';

import 'package:Joya_Italiano/Models/userData.dart';
import 'package:flutter/material.dart';

class UsersTile extends StatelessWidget {
  final UserData users;
  UsersTile({this.users});

  @override
  Widget build(BuildContext context) {
    Color randomColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];

    if (checkDate()) {
      return Padding(
        padding: EdgeInsets.only(top: 16, bottom: 0, left: 12, right: 12),
        child: Card(
          color: Colors.grey.shade900,
          child: ClipPath(
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3))),
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(right: BorderSide(color: randomColor, width: 5))),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: randomColor,
                ),
                title: Text(users.name),
                subtitle: Row(
                  children: [
                    Text(users.date),
                    Spacer(),
                    Text(users.time),
                    Spacer(),
                    Text(users.number.toString() + ' Quests'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 0.0,
      );
    }
  }

  bool checkDate() {
    var temp = DateTime.now();
    var d1 = DateTime.utc(temp.year, temp.month, temp.day);

    var d2 = DateTime.parse(users.date); //you can add today's date here
    print(d1);
    print(d2);

    if (d1.toString().contains(users.date.toString())) {
      print(d1.toString().compareTo(users.date.toString()));
      return true;
    } else if (d2.compareTo(d1) >= 0) {
      print(d2.compareTo(d1));
      return true;
    } else {
      print(d2.compareTo(d1));
      return false;
    }
  }
}
