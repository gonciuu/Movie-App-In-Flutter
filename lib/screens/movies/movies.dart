import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:moviestro/auth/auth_service.dart';
import 'package:moviestro/realtime_database/realtime_database_service.dart';
import 'package:moviestro/screens/movies/list_views/movie_card.dart';

class Movies extends StatefulWidget {
  final List<dynamic> listOfMovies;
  Movies(this.listOfMovies);

  @override
  _MoviesState createState() => _MoviesState();
}

enum WhyList { moviesFromAPI, moviesFromDB }

class _MoviesState extends State<Movies> {


  bool isFromApi = true;
  final _auth = AuthService();
  final _db = RealtimeDatabaseService();
  int itemCount;
  List<dynamic> listOfMoviesInDB;

  void getDBList() async{
      listOfMoviesInDB = await _db.getMovies();
      print(listOfMoviesInDB);
      setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDBList();
  }

  @override
  Widget build(BuildContext context) {


    if(isFromApi) itemCount = widget.listOfMovies.length;
    else itemCount = listOfMoviesInDB.length;


    Map randomMovie = {};
    if (isFromApi)
      randomMovie =
          widget.listOfMovies[Random().nextInt(widget.listOfMovies.length - 1)];
    else
      randomMovie = listOfMoviesInDB[Random().nextInt(listOfMoviesInDB.length)];

    String url='';
    if(randomMovie['poster_path'].toString().contains('http')) url = randomMovie['poster_path'];
    else url = 'https://image.tmdb.org/t/p/w500/${randomMovie['poster_path']}';


    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(
                        Icons.exit_to_app,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      onTap: () async {
                        await _auth.signOut();
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Top pick movies ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                        child: TextField(
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[200],
                              size: 24.0,
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                          cursorColor: Colors.grey[200],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    PopupMenuButton<WhyList>(
                      icon: Icon(
                        Icons.filter_list,
                        size: 28.0,
                        color: Colors.white,
                      ),
                      onSelected: (WhyList result) {
                        setState(() {
                          switch (result) {
                            case WhyList.moviesFromAPI:
                              setState(() => isFromApi = true);
                              break;
                            case WhyList.moviesFromDB:
                                isFromApi = false;
                                getDBList();
                              break;
                          }
                        });
                      },
                      itemBuilder: (context) => <PopupMenuEntry<WhyList>>[
                        const PopupMenuItem(
                          child: Text(
                            "Top popular",
                            style: TextStyle(color: Colors.white),
                          ),
                          value: WhyList.moviesFromAPI,
                        ),
                        PopupMenuItem(
                            child: Text("From users",
                                style: TextStyle(color: Colors.white)),
                            value: WhyList.moviesFromDB)
                      ],
                      color: Colors.grey[800],
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        '$url',
                        width: 143,
                        height: 214,
                        scale :3.5
                      ),
                    ),
                    SizedBox(width: 30.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${randomMovie['title']}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w900),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: 2.0,
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  " ${DateFormat("yyyy-MM-dd").parse(randomMovie['release_date']).year}",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          RatingBar(
                            unratedColor: Colors.grey[800],
                            itemSize: 26.0,
                            initialRating: randomMovie['vote_average'] / 2,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 10.0,
                            ),
                            onRatingUpdate: (double value) {},
                            ignoreGestures: true,
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 30.0, 0.0),
                                  child: Text(
                                    "${randomMovie['overview']}",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey[400]),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Popularity : ${randomMovie['popularity']}",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[200]),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.star_border,
                                  color: Colors.amber, size: 32.0),
                              Text(
                                " ${randomMovie['vote_average']}",
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey[200]),
                                textAlign: TextAlign.left,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Suggested for you",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ListView.builder(
                  itemBuilder: (view, index) {
                    if (isFromApi)
                      return MovieCard(widget.listOfMovies[index]);
                    else
                      return MovieCard(listOfMoviesInDB[index]);
                  },
                  itemCount: itemCount,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent[200],
        onPressed: () async{
          await Navigator.pushNamed(context, "/add_movie");
          getDBList();
        },
      ),
    );
  }
}
