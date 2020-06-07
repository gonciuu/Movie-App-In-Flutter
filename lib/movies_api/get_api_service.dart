
import 'dart:convert';

import 'package:http/http.dart';
import 'package:moviestro/movies_api/secret_api_token.dart';

class GetApiService{

  GetApiService({this.language});

  String language;
  List<dynamic> listOfMovies = [];
  String apiKey = SecretApiToken().getApiKey();

  Future getMoviesApi(int page) async{
    Response response = await get("https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=$language&page=$page");
    Map api = jsonDecode(response.body);
    this.listOfMovies = api['results'];
  }

}