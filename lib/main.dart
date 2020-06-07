import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviestro/auth/auth_service.dart';
import 'package:moviestro/screens/loading/loading.dart';
import 'package:moviestro/screens/movies/add_movie.dart';
import 'package:moviestro/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      "/loading": (context) => Loading(),
      "/moviestro": (context) => Moviestro(),
      "/add_movie": (context) => AddMovie(),
    },
    initialRoute: "/loading",
  ));
}

class Moviestro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    List<dynamic> listOfMovies = map['listOfMovies'];
    return StreamProvider<FirebaseUser>.value(
        value: AuthService().user, child: Wrapper(listOfMovies));
  }
}
