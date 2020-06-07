import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moviestro/movies_api/get_api_service.dart';
import 'package:moviestro/realtime_database/realtime_database_service.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final _api = GetApiService();
  final _db = RealtimeDatabaseService();

  void getApi() async {
    String locale = await Devicelocale.currentLocale;
    locale = locale.replaceAll("_", "-");
    _api.language = locale;
    List<dynamic> listOfMovies = [];
    for(int i =1;i<=5;i++){
      await _api.getMoviesApi(i);
      for(Map j in _api.listOfMovies){
        listOfMovies.add(j);
      }
    }
    Navigator.pushReplacementNamed(context, "/moviestro", arguments: {"listOfMovies": listOfMovies});
  }

  @override
  void initState() {
    super.initState();
    getApi();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitFadingCube(size: 70.0, color: Colors.grey[200]),
          SizedBox(height: 50.0),
          SizedBox(
            width: 305.0,
            child: TypewriterAnimatedTextKit(
              onTap: () {
                print("Tap Event");
              },
              text: ["Loading data..."],
              textStyle: TextStyle(
                  fontSize: 42.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              textAlign: TextAlign.start,
              alignment: AlignmentDirectional.topStart,
              speed: Duration(milliseconds: 200),
            ),
          )
        ],
      ),
    );
  }
}
