import 'package:Joya_Italiano/Constants/constants.dart';
import 'package:Joya_Italiano/theme.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dashboard/adminDashboard.dart';

class PinCodePanel extends StatefulWidget {
  @override
  _PinCodePanelState createState() => _PinCodePanelState();
}

class _PinCodePanelState extends State<PinCodePanel> {
  Future<void> openSession() async {
    SharedPreferences sessionStatus = await SharedPreferences.getInstance();

    sessionStatus.setBool('isLogged', true);
  }

  TextEditingController pincodeController = TextEditingController();
  String pincode = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
          child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pinCodeTextField(),
              proceedButton(),
            ],
          ),
        ),
      )),
    );
  }

  Padding pinCodeTextField() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        child: PinCodeTextField(
          textStyle: TextStyle(color: Colors.white, fontSize: 32.0),
          selectedColor: Colors.white,
          selectedFillColor: Colors.white,
          length: 4,
          activeColor: Colors.white,
          backgroundColor: primaryColor,
          inactiveColor: Colors.grey.shade200,
          disabledColor: Colors.grey.shade200,
          obsecureText: false,
          animationType: AnimationType.fade,
          shape: PinCodeFieldShape.box,
          animationDuration: Duration(milliseconds: 300),
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 47,
          fieldWidth: 43,
          controller: pincodeController,
          onChanged: (value) {
            setState(() {
              pincode = pincodeController.text;
            });
          },
        ),
      ),
    );
  }

  ButtonTheme proceedButton() {
    return ButtonTheme(
        disabledColor: Colors.white70,
        height: 55,
        minWidth: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: RaisedButton(
            color: Colors.white,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10)),
            child: Text(
              "PROCEED",
              style: GoogleFonts.ubuntu(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: pincodeController.text.isNotEmpty
                      ? Colors.black
                      : Colors.black),
            ),
            onPressed: proceed,
          ),
        ));
  }

  void proceed() async {
    if (pincode == adminKey) {
      await openSession();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminDashboard()),
      );
    } else {
      setState(() => _scaffoldKey.currentState.showSnackBar(
          snackBar(('Verification code is incorrect, try again'))));
    }

    print(pincode);
    print(adminKey);
  }

  SnackBar snackBar(String text) {
    return SnackBar(
        backgroundColor: Colors.white,
        content: new Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.ubuntu(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        duration: new Duration(seconds: 3));
  }
}
