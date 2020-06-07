
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviestro/screens/movies/movies.dart';
import 'package:provider/provider.dart';
import 'auth/authience.dart';

class Wrapper extends StatelessWidget {

  final List<dynamic> listOfMovies;
  Wrapper(this.listOfMovies);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    if(user==null) {
      return Authience();
    }
    else {
      print(user.uid);
      return Movies(this.listOfMovies);
    }
  }
}
