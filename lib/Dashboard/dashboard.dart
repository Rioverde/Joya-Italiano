import 'package:Joya_Italiano/Database/database.dart';
import 'package:Joya_Italiano/Maps/showLocation.dart';
import 'package:Joya_Italiano/Models/user.dart';
import 'package:Joya_Italiano/Models/userData.dart';
import 'package:Joya_Italiano/Services/AuthServices.dart';
import 'package:Joya_Italiano/Services/regexValidation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

String name = '';
String month;
String day;
int number = 0;
String phone = '';

class CustomerDashboard extends StatefulWidget {
  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}

// final users = Provider.of<List<UserData>>(context);
// users.forEach((users) {
//   print(name);
//   if (users.name == name) {
//     setState(()   {
//       print(users.name);
//       username = users.name;
//       print(users.date);
//       tempDate = users.date;
//       print(users.time);
//       tempTime = users.time;
//     });
//   } else {
//     print('error in users');
//   }
// });

class _CustomerDashboardState extends State<CustomerDashboard> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _date = "Not set";
  String _time = "Not set";

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
      value: DatabaseService().users,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Reservations"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.gps_fixed),
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShowLocation()));
              },
            ),
            SizedBox(
              width: 8,
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              children: [
                buildReservationBox(),
                divider(),
                reservationBox(),
              ],
            ),
          )),
        ),
      ),
    );
  }

  StreamBuilder reservationBox() {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;

          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(Radius.circular(5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        userData.name,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        userData.date,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        userData.time,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.black,
                            onPressed: () async {
                              await DatabaseService(uid: user.uid)
                                  .deleteUserData();
                            })),
                  ],
                ),
              ),
            );
          } else {}
          return SizedBox(
            width: 22,
          );
        });
  }

  Container buildReservationBox() {
    return new Container(
      width: double.infinity,
      color: Colors.transparent,
      child: new Container(
          child: returnContent(),
          decoration: new BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: new BorderRadius.all(Radius.circular(5)),
          )),
    );
  }

  Padding returnContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: RichText(
                text: TextSpan(
                  text: "Jo",
                  style: GoogleFonts.ubuntu(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Y",
                        style: TextStyle(color: Colors.yellow.shade700)),
                    TextSpan(
                        text: "a Italiano",
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ),
            enterNameField(),
            SizedBox(
              height: 24,
            ),
            enterNumberField(),
            SizedBox(
              height: 24,
            ),
            enterPhoneField(),
            SizedBox(
              height: 24,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 4.0,
              onPressed: () {
                DatePicker.showDatePicker(context,
                    theme: DatePickerTheme(
                      doneStyle: TextStyle(color: primaryColor),
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true,
                    minTime: DateTime(2020, 1, 1),
                    maxTime: DateTime(2021, 12, 31), onConfirm: (date) {
                  print('confirm $date');
                  if (date.day < 10) {
                    day = '0' + date.day.toString();
                  } else {
                    day = date.day.toString();
                  }

                  if (date.month < 10) {
                    month = '0' + date.month.toString();
                  } else {
                    month = date.month.toString();
                  }

                  _date = '${date.year}-$month-$day';
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.date_range,
                                size: 18.0,
                                color: primaryColor,
                              ),
                              Text(
                                " $_date",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "  Change",
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              color: Colors.white,
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 4.0,
              onPressed: () {
                DatePicker.showTimePicker(context,
                    showSecondsColumn: false,
                    theme: DatePickerTheme(
                      doneStyle: TextStyle(color: primaryColor),
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true, onConfirm: (time) {
                  _time = '${time.hour} : ${time.minute}';
                  print('confirm time $time');

                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                size: 18.0,
                                color: primaryColor,
                              ),
                              Text(
                                " $_time",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "  Change",
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              color: Colors.white,
            ),
            confirmButton("Confirm", () async {
              if (_formKey.currentState.validate()) {
                var firebaseUser = await FirebaseAuth.instance.currentUser();
                await DatabaseService(uid: firebaseUser.uid)
                    .updateUserData(name, false, _date, _time, number, phone);
                setState(() {});
              } else
                print('Error in update');
            }),
          ],
        ),
      ),
    );
  }

  Padding divider() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 16),
      child: Divider(
        color: Colors.blue,
        thickness: 3,
      ),
    );
  }

  TextFormField enterNameField() {
    return TextFormField(
      validator: (value) => validateNameCases(value),
      onChanged: (val) {
        setState(() => name = val);
      },
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Enter name of the Reservant",
        prefixIcon: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
    );
  }

  TextFormField enterNumberField() {
    return TextFormField(
      validator: (value) => validateNumberCases(int.parse(value)),
      onChanged: (val) {
        setState(() => number = int.parse(val));
        print(number);
      },
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Enter number of people",
        prefixIcon: Icon(
          Icons.group,
          color: Colors.white,
        ),
      ),
    );
  }

  TextFormField enterPhoneField() {
    return TextFormField(
      validator: (value) => validatePhoneCases(value),
      onChanged: (val) {
        setState(() => phone = (val));
        print(phone);
      },
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Enter your phone number",
        prefixIcon: Icon(
          Icons.call,
          color: Colors.white,
        ),
      ),
    );
  }

  Padding confirmButton(String text, Function pressed) {
    print(number);
    print(phone);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: ButtonTheme(
        disabledColor: disabledState,
        height: 55,
        minWidth: double.infinity,
        child: RaisedButton(
          color: Colors.white,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10)),
          child: Text(
            text,
            style: GoogleFonts.ubuntu(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          onPressed: pressed,
        ),
      ),
    );
  }
}
