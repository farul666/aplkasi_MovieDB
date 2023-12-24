class Movie {
  int? id;
  String? title;
  double? voteAverage;
  String? releaseDate;
  String? overView;
  String? posterPath;

  Movie(this.id, this.title, this.voteAverage, this.releaseDate, this.overView,
      this.posterPath);
  Movie.fromJson(Map<String, dynamic> json) {
    this.id = json['id'] as int;
    this.title = json['title'];
    this.voteAverage = json['vote_average'] * 1.0 as double;
    this.releaseDate = json['release_date'];
    this.overView = json['overview'];
    this.posterPath = json['poster_path'];
  }
}
