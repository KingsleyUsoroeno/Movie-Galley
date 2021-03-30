class ResultEntity {
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

  ResultEntity({
    this.popularity,
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
    this.releaseDate,
  });

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
