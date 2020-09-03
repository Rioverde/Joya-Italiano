import 'package:Joya_Italiano/Auth/auth.dart';
import 'package:Joya_Italiano/Screens/pincodePanel.dart';
import 'package:Joya_Italiano/main.dart';
import 'package:Joya_Italiano/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Choise extends StatefulWidget {
  @override
  _ChoiseState createState() => _ChoiseState();
}

class _ChoiseState extends State<Choise> {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/main.png"), context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Reservations",
          textAlign: TextAlign.center,
          style: GoogleFonts.ubuntu(
              fontSize: 24.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            aphroditeText(),
            choiseButton('Admin', () {
              print('Admin');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PinCodePanel()));
            }),
            choiseButton('Customer', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            }),
          ],
        ),
      ),
    );
  }

  Container aphroditeText() {
    return Container(
      child: Image(image: logo),
    );
  }

  Padding choiseButton(String text, Function pressed) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
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
