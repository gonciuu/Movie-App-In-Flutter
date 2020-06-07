import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviestro/auth/auth_service.dart';
import 'package:moviestro/movie.dart';
import 'package:moviestro/realtime_database/realtime_database_service.dart';
import 'package:moviestro/screens/movies/movies.dart';

class AddMovie extends StatefulWidget {


  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  final _db = RealtimeDatabaseService();
  final _auth = AuthService();
  String title, imgUrl, overview;
  double rating;
  String realaseYear;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('img/add_movie_bg.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 40.0,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text("Add new movie",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "If u love watching",
                    style: TextStyle(color: Colors.grey[400], fontSize: 22.0),
                  ),
                  SizedBox(
                    height: 70.0,
                  ),
                  Form(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                cursorColor: Colors.white,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w300),
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w300),
                                    hintText: "Enter movie title",
                                    fillColor: Colors.grey[900],
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 20.0),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.amber, width: 1.0)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0))),
                                onChanged: (str) =>
                                    setState(() => this.title = str),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.white,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300),
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w300),
                                      hintText:
                                          "Enter movie realase date yyyy-MM-dd",
                                      fillColor: Colors.grey[900],
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 25.0, horizontal: 20.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.amber, width: 1.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0))),
                                  onChanged: (str) =>
                                      setState(() => this.realaseYear = str)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.white,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300),
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w300),
                                      hintText: "Enter rating 1-10",
                                      fillColor: Colors.grey[900],
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 25.0, horizontal: 20.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.amber, width: 1.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0))),
                                  onChanged: (str) => setState(
                                      () => this.rating = double.parse(str))),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                  cursorColor: Colors.white,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300),
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w300),
                                      hintText: "Enter short overview",
                                      fillColor: Colors.grey[900],
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 25.0, horizontal: 20.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.amber, width: 1.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0))),
                                  onChanged: (str) =>
                                      setState(() => this.overview = str)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                  cursorColor: Colors.white,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300),
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w300),
                                      hintText: "Enter poster image URL",
                                      fillColor: Colors.grey[900],
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 25.0, horizontal: 20.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.amber, width: 1.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0))),
                                  onChanged: (str) =>
                                      setState(() => this.imgUrl = str)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                color: Colors.amber[500],
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                onPressed: () async {
                                  await _db.insertMovie(Movie(
                                      id: DateTime.now().millisecondsSinceEpoch,
                                      userId: await _auth.getCurrentUser(),
                                      title: title,
                                      rating: 6.6,
                                      overview: overview,
                                      realaseYear: realaseYear,
                                      imgUrl: imgUrl));
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Add new movie",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.0),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
