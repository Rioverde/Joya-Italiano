import 'package:Joya_Italiano/Services/regexValidation.dart';
import 'package:Joya_Italiano/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Services/AuthServices.dart';
import '../theme.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKeyLogin = GlobalKey<ScaffoldState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKeyLogin,
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
              sigInButton(),
              dontHaveAccount(),
            ],
          ),
        ),
      ),
    );
  }

  Padding dontHaveAccount() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () => widget.toggleView(),
        child: RichText(
          text: TextSpan(
            text: "Don't have an account ? ",
            style: GoogleFonts.ubuntu(
                color: Colors.blue,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
            children: <TextSpan>[
              TextSpan(
                  text: " Register", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
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
            onChanged: (val) {
              setState(() => email = val);
            },
            validator: (value) => validateEmailCases(value),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email, color: Colors.white),
              hintText: "Email",
            )));
  }

  Padding sigInButton() {
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
                'Sign In',
                style: GoogleFonts.ubuntu(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  dynamic result =
                      await _auth.signInWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() {
                      error = 'Could not sign in with those credentials';
                      print(error);
                      setState(() => scaffoldKeyLogin.currentState.showSnackBar(
                          snackBar('Incorrect email or password')));
                    });
                  } else {
                    Navigator.pop(context);
                  }
                }
              }),
        ));
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
