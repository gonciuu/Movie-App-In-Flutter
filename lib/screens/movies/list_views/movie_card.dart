import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class MovieCard extends StatelessWidget {
  final Map movie;
  MovieCard(this.movie);
  @override
  Widget build(BuildContext context) {
    String url='';
    if(movie['poster_path'].toString().contains('http')) url = movie['poster_path'];
    else url = 'https://image.tmdb.org/t/p/w500/${movie['poster_path']}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            child: Image.network(
                '$url',
                height: 150,
                width: 100,
                scale: 5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "${movie['title']}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Text(
                        " ${DateFormat("yyyy-MM-dd").parse(movie['release_date']).year}",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 17.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      flex: 1,
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                RatingBar(
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (double value) {},
                  itemCount: 5,
                  initialRating: movie['vote_average']/2,
                  allowHalfRating: true,
                  itemSize: 25.0,
                  unratedColor: Colors.grey[800],
                  ignoreGestures: true,
                  direction: Axis.horizontal,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 0.0),
                        child: Text(
                          "${movie['overview']}",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16.0,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.star_border, color: Colors.amber, size: 26.0),
                    Text(
                      " ${movie['vote_average']}",
                      style: TextStyle(
                          fontSize: 20.0,
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
    );
  }
}
