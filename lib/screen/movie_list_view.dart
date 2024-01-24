import 'package:flutter/material.dart';

import '../komponen/http_helper.dart';
import 'movie_detail.dart';

class MovieListView extends StatefulWidget {
  //2
  const MovieListView({Key? key}) : super(key: key);
  @override
  State<MovieListView> createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  Icon searchIcon = const Icon(Icons.search);
  Widget titleBar = const Text(
    'Daftar Film',
    style: TextStyle(color: Colors.white),
  );

  late int moviesCount;
  late List movies;
  late HttpHelper helper;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clap board1184339.jpg';

  @override
  void initState() {
    defaultList();
    super.initState();
  }

  void toggleSearch() {
    setState(() {
      if (searchIcon.icon == Icons.search) {
        searchIcon = const Icon(Icons.cancel);
        titleBar = TextField(
          autofocus: true,
          onSubmitted: (text) {
            searchMovies(text);
          },
          decoration: const InputDecoration(hintText: 'Ketik kata pencarian'),
          textInputAction: TextInputAction.search,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        );
      } else {
        setState(() {
          searchIcon = const Icon(Icons.search);
          titleBar = const Text(
            'Daftar Film',
            style: TextStyle(color: Colors.white),
          );
        });
        defaultList();
      }
    });
  }

  Future searchMovies(String text) async {
    List searchedMovies = await helper.findMovies(text);
    setState(() {
      movies = searchedMovies;
      moviesCount = movies.length;
    });
  }

  Future defaultList() async {
    //5
    moviesCount = 0;
    movies = [];
    helper = HttpHelper();
    List moviesFromAPI = [];
    moviesFromAPI = await helper.getUpcomingAsList();
    setState(() {
      movies = moviesFromAPI;
      moviesCount = movies.length;
    });
  }

  Future topRatedList() async {
    moviesCount = 0;
    movies = [];
    helper = HttpHelper();
    List moviesFromAPI = [];
    moviesFromAPI = await helper.getTopRatedAsList();
    setState(() {
      movies = moviesFromAPI;
      moviesCount = movies.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image; //tambahan image
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Upcoming'),
              onTap: () {
                Navigator.pop(context); //untuk menutup drawer
                setState(() {
                  searchIcon = const Icon(Icons.search);
                  titleBar = const Text(
                    'Daftar Film',
                    style: TextStyle(color: Colors.white),
                  );
                });
                defaultList(); //perintah getUpcoming()
              },
            ),
            ListTile(
              title: const Text('Cari'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  searchIcon = const Icon(Icons.cancel);
                  titleBar = TextField(
                    autofocus: true,
                    onSubmitted: (text) {
                      searchMovies(text); //perintah cari Movie
                    },
                    decoration:
                        const InputDecoration(hintText: 'Ketik kata pencarian'),
                    textInputAction: TextInputAction.search,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  );
                });
              },
            ),
            ListTile(
              title: const Text('Top Rated'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  this.searchIcon = Icon(Icons.search);
                  this.titleBar = Text('Daftar Film Rating Tertinggi');
                });
                topRatedList();
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: titleBar,
        actions: [
          IconButton(
            icon: searchIcon,
            onPressed: toggleSearch,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: moviesCount,
        itemBuilder: (context, position) {
// tambahan kode untuk akses image pada url
          if (movies[position].posterPath != null) {
            image = NetworkImage(iconBase + movies[position].posterPath);
          } else {
            image = NetworkImage(defaultImage);
          }
//=============================
          return Card(
            elevation: 2,
            child: ListTile(
              onTap: () {
                //1
                MaterialPageRoute route = MaterialPageRoute(
                  //2
                  builder: (context) {
                    return MovieDetail(
                      selectedMovie: movies[position],
                    );
                  },
                );
                Navigator.push(context, route); //3
              },
              leading: CircleAvatar(
                backgroundImage: image,
              ),
              title: Text(movies[position].title),
              subtitle: Text(
                '${'Release Date :  ' + movies[position].releaseDate}   Movie Rating :  ${movies[position].voteAverage}',
              ),
            ),
          );
        },
      ),
    );
  }
}
