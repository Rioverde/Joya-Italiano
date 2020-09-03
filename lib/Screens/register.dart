import 'package:Joya_Italiano/Services/AuthServices.dart';
import 'package:Joya_Italiano/Services/regexValidation.dart';
import 'package:Joya_Italiano/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKeyPassword =
      GlobalKey<ScaffoldState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKeyPassword,
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: logo),
              loginEmailField(),
              loginPasswordField(),
              registerButton(),
              alreadyHaveAccount(),
            ],
          ),
        ),
      ),
    );
  }

  Padding alreadyHaveAccount() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () => widget.toggleView(),
        child: RichText(
          text: TextSpan(
            text: "Already have an account ? ",
            style: GoogleFonts.ubuntu(
                color: Colors.blue,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
            children: <TextSpan>[
              TextSpan(text: " Login", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Text aphroditeText() {
    return Text(
      "Joya_Italiano",
      textAlign: TextAlign.center,
      style: GoogleFonts.cinzelDecorative(
          fontSize: 50.0, fontWeight: FontWeight.normal, color: Colors.white),
    );
  }

  Padding loginPasswordField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: TextFormField(
        validator: (value) => validatePasswordCases(value),
        onChanged: (val) {
          setState(() => password = val);
        },
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Enter Password",
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Padding loginEmailField() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: TextFormField(
            validator: (value) => validateEmailCases(value),
            onChanged: (val) {
              setState(() => email = val);
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person, color: Colors.white),
              hintText: "Email",
            )));
  }

  Padding registerButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: ButtonTheme(
        disabledColor: disabledState,
        height: 55,
        minWidth: double.infinity,
        child: RaisedButton(
          color: Colors.white,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10)),
          child: Text(
            'Register',
            style: GoogleFonts.ubuntu(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              dynamic result =
                  await _auth.registerWithEmailAndPassword(email, password);
              if (result == null) {
                setState(() {
                  error = 'Please supply a valid email';
                  setState(() => scaffoldKeyPassword.currentState
                      .showSnackBar(snackBar('Incorrect email or password')));
                });
              } else {
                Navigator.pop(context);
              }
            }
          },
        ),
      ),
    );
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
