 class MovieResult {
  dynamic popularity;
  dynamic voteCount;
  bool video;
  String posterPath;
  dynamic id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  String overview;
  String releaseDate;

   MovieResult(
      {this.popularity,
      this.voteCount,
      this.video,
      this.posterPath,
      this.id,
      this.adult,
      this.backdropPath,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.title,
      this.overview,
      this.releaseDate});

   MovieResult.fromJson(Map<String, dynamic> json) {
    popularity = json['popularity'];
    voteCount = json['vote_count'];
    video = json['video'];
    posterPath = json['poster_path'];
    id = json['id'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = this.popularity;
    data['vote_count'] = this.voteCount;
    data['video'] = this.video;
    data['poster_path'] = this.posterPath;
    data['id'] = this.id;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['title'] = this.title;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }

  @override
  String toString() {
    return 'Results{_popularity: $popularity, _voteCount: $voteCount, '
        '_video: $video, _posterPath: $posterPath, _id: $id, '
        '_adult: $adult, _backdropPath: $backdropPath,'
        ' _originalLanguage: $originalLanguage, '
        '_originalTitle: $originalTitle, '
        '_genreIds: $genreIds, _title: $title,'
        ' _overview: $overview, _releaseDate: $releaseDate}';
  }
}
