import 'package:flutter/material.dart';
import 'package:moviestro/screens/auth/register.dart';
import 'package:moviestro/screens/auth/sign_in.dart';

class Authience extends StatefulWidget {
  @override
  _AuthienceState createState() => _AuthienceState();
}

class _AuthienceState extends State<Authience> {
  bool isSignInView = true;

  void changeView()=> setState(()=> isSignInView = !isSignInView);

  @override
  Widget build(BuildContext context) {
    if (isSignInView)
      return SignIn(changeView);
    else
      return Register(changeView);
  }
}
