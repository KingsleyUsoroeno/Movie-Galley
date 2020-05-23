class Results {
  double _popularity;
  int _voteCount;
  bool _video;
  String _posterPath;
  int _id;
  bool _adult;
  String _backdropPath;
  String _originalLanguage;
  String _originalTitle;
  List<int> _genreIds;
  String _title;
  String _overview;
  String _releaseDate;

  Results(
      {double popularity,
      int voteCount,
      bool video,
      String posterPath,
      int id,
      bool adult,
      String backdropPath,
      String originalLanguage,
      String originalTitle,
      List<int> genreIds,
      String title,
      int voteAverage,
      String overview,
      String releaseDate}) {
    this._popularity = popularity;
    this._voteCount = voteCount;
    this._video = video;
    this._posterPath = posterPath;
    this._id = id;
    this._adult = adult;
    this._backdropPath = backdropPath;
    this._originalLanguage = originalLanguage;
    this._originalTitle = originalTitle;
    this._genreIds = genreIds;
    this._title = title;
    this._overview = overview;
    this._releaseDate = releaseDate;
  }

  double get popularity => _popularity;

  set popularity(double popularity) => _popularity = popularity;

  int get voteCount => _voteCount;

  set voteCount(int voteCount) => _voteCount = voteCount;

  bool get video => _video;

  set video(bool video) => _video = video;

  String get posterPath => _posterPath;

  set posterPath(String posterPath) => _posterPath = posterPath;

  int get id => _id;

  set id(int id) => _id = id;

  bool get adult => _adult;

  set adult(bool adult) => _adult = adult;

  String get backdropPath => _backdropPath;

  set backdropPath(String backdropPath) => _backdropPath = backdropPath;

  String get originalLanguage => _originalLanguage;

  set originalLanguage(String originalLanguage) =>
      _originalLanguage = originalLanguage;

  String get originalTitle => _originalTitle;

  set originalTitle(String originalTitle) => _originalTitle = originalTitle;

  List<int> get genreIds => _genreIds;

  set genreIds(List<int> genreIds) => _genreIds = genreIds;

  String get title => _title;

  set title(String title) => _title = title;

  String get overview => _overview;

  set overview(String overview) => _overview = overview;

  String get releaseDate => _releaseDate;

  set releaseDate(String releaseDate) => _releaseDate = releaseDate;

  Results.fromJson(Map<String, dynamic> json) {
    _popularity = json['popularity'];
    _voteCount = json['vote_count'];
    _video = json['video'];
    _posterPath = json['poster_path'];
    _id = json['id'];
    _adult = json['adult'];
    _backdropPath = json['backdrop_path'];
    _originalLanguage = json['original_language'];
    _originalTitle = json['original_title'];
    _genreIds = json['genre_ids'].cast<int>();
    _title = json['title'];
    _overview = json['overview'];
    _releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = this._popularity;
    data['vote_count'] = this._voteCount;
    data['video'] = this._video;
    data['poster_path'] = this._posterPath;
    data['id'] = this._id;
    data['adult'] = this._adult;
    data['backdrop_path'] = this._backdropPath;
    data['original_language'] = this._originalLanguage;
    data['original_title'] = this._originalTitle;
    data['genre_ids'] = this._genreIds;
    data['title'] = this._title;
    data['overview'] = this._overview;
    data['release_date'] = this._releaseDate;
    return data;
  }

  @override
  String toString() {
    return 'Results{_popularity: $_popularity, _voteCount: $_voteCount, _video: $_video, _posterPath: $_posterPath, _id: $_id, _adult: $_adult, _backdropPath: $_backdropPath, _originalLanguage: $_originalLanguage, _originalTitle: $_originalTitle, _genreIds: $_genreIds, _title: $_title, _overview: $_overview, _releaseDate: $_releaseDate}';
  }
}
