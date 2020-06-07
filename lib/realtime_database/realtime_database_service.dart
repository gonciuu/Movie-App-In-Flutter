
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:moviestro/movie.dart';
class RealtimeDatabaseService{

  FirebaseDatabase _database = FirebaseDatabase.instance;

  Future insertMovie(Movie movie) async{
    try{
      Map movieMap = movieToMap(movie);
      await _database.reference().child('Movies').child(movie.id.toString()).set(movieMap);
    }catch(e){
      print(e);
    }
  }
  
  Map movieToMap(Movie movie){
    Map map = Map();
    map['id'] = movie.id;
    map['title'] = movie.title;
    map['release_date'] = movie.realaseYear;
    map['vote_average'] = movie.rating;
    map['overview'] = movie.overview;
    map['userId'] = movie.userId;
    map['poster_path'] = movie.imgUrl;
    return map;
  }


  Future getMovies() async{
    List<dynamic> listOfMovies=[];
    try{
      await _database.reference().child("Movies").once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> map = snapshot.value;
        listOfMovies = map.values.toList();
      });
      return listOfMovies;
    }catch(e){
      print(e);
      return null;
    }
  }



}


