import 'package:flutter/material.dart';
import '../model/movie.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({Key? key, required this.selectedMovie}) : super(key: key);

  final Movie selectedMovie;

  @override
  Widget build(BuildContext context) {
    String path;
    double screenHeight = MediaQuery.of(context).size.height;

    if (selectedMovie.posterPath != null) {
      path = 'https://image.tmdb.org/t/p/w500/${selectedMovie.posterPath}';
    } else {
      path =
          'https://image.freeimages.com/images/large-previews/5eb/movie-clapboard-11844399.jpg';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMovie.title}',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
            )),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: screenHeight / 1.5,
                child: Image.network(path),
              ),
              Text('${selectedMovie.overView}'),
              // Untuk Rating dan nama pembuat
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      'Movie Rating : ${selectedMovie.voteAverage}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    Expanded(
                      child: Text(
                        'Release Date : ${selectedMovie.releaseDate}',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),

              //Container untuk nama dan NIM
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Created By\nFahrul Fauji\nNIM : 21201195',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
