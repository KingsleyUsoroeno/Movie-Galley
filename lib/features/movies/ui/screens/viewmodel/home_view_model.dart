import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
//  final dbHelper = DBProvider.db;
//  PopularMoviesDatabaseModel allPopularMovies;
//  NowPlayingMoviesDatabaseModel allNowPlayingMovies;
//
//  // DIFFERENT ERROR MESSAGES FOR THE VARIOUS LIST VIEWS ON THE UI
//  String nowPlayingNetworkExceptionMessage = "";
//  String popularMoviesNetworkExceptionMessage = "";
//  String movieCategoryNetworkExceptionMessage = "";
//  final _appRepository = RemoteMoviesRepository();
//
//  // LOADING STATE OF THE DIFFERENT LIST VIEWS
//  bool _isNowPlayingLoading = false;
//  bool _isMovieResponseLoading = false;
//  bool _isPopularMovieResponseLoading = false;
//
//  // SUCCESS STATE OF THE DATA BEING FETCHED FROM THE NETWORK
//  bool _didFetchMovieCategory = false;
//  bool _didFetchPopularMovies = false;
//  bool _didFetchNowPlaying = false;
//
//  // GETTERS
//  bool get didFetchMovieCategory => _didFetchMovieCategory;
//
//  bool get didFetchPopularMovies => _didFetchPopularMovies;
//
//  bool get didFetchNowPlaying => _didFetchNowPlaying;
//
//  bool get isPopularMovieResponseLoading => _isPopularMovieResponseLoading;
//
//  bool get isNowPlayingLoading => _isNowPlayingLoading;
//
//  bool get isMovieResponseLoading => _isMovieResponseLoading;
//
//  HomeViewModel() {
//    fetchMoviesAndSaveToDb();
//    fetchNowPlayingAndSaveToDb();
//    fetchPopularMoviesAndSaveToDb();
//    //getAllNowPlayingMoviesFromDb();
//    //getAllPopularMoviesFromDb();
//    //getAllMoviesFromDb();
//  }
//
//  Future<void> fetchMoviesAndSaveToDb() async {
//    /// Start showing the loader
//    _isMovieResponseLoading = true;
//    notifyListeners();
//
//    /// Wait for response
//    NetworkResponse networkingResponse = await _appRepository.getMovieCategory();
//
//    /// We check the type of response and update the required field
//    if (networkingResponse is NetworkingResponseData) {
//      _didFetchMovieCategory = true;
//      // save all the movies to th db
//      _saveMovieToDb(networkingResponse.dataResponse as Movies);
//      notifyListeners();
//    } else if (networkingResponse is NetworkingException) {
//      /// Updating the errorMessage when fails
//      movieCategoryNetworkExceptionMessage = networkingResponse.message;
//      _didFetchMovieCategory = false;
//
//      notifyListeners();
//    }
//
//    /// Stop the loader
//    _isMovieResponseLoading = false;
//    notifyListeners();
//  }
//
//  Future<void> fetchNowPlayingAndSaveToDb() async {
//    /// Start showing the loader
//    _isNowPlayingLoading = true;
//    notifyListeners();
//
//    /// Wait for response
//    NetworkResponse networkingResponse = await _appRepository.getNowPlayingMovies();
//
//    if (networkingResponse is NetworkingResponseData) {
//      _didFetchNowPlaying = true;
//      _saveNowPlayingMoviesToDb(networkingResponse.dataResponse as NowPlayingResponse);
//      notifyListeners();
//    } else if (networkingResponse is NetworkingException) {
//      /// Updating the errorMessage when fails
//      nowPlayingNetworkExceptionMessage = networkingResponse.message;
//      _didFetchNowPlaying = false;
//      notifyListeners();
//    }
//
//    /// Stop the loader
//    _isNowPlayingLoading = false;
//    notifyListeners();
//  }
//
//  Future<void> fetchPopularMoviesAndSaveToDb() async {
//    /// Start showing the loader
//    _isPopularMovieResponseLoading = true;
//    notifyListeners();
//
//    /// Wait for response
//    NetworkResponse networkingResponse = await _appRepository.getPopularMovies();
//
//    if (networkingResponse is NetworkingResponseData) {
//      _didFetchPopularMovies = true;
//      _savePopularMoviesToDb(networkingResponse.dataResponse as PopularMovie);
//      notifyListeners();
//
//      print("popular movies is ${networkingResponse.dataResponse as PopularMovie}");
//    } else if (networkingResponse is NetworkingException) {
//      /// Updating the errorMessage when fails
//      popularMoviesNetworkExceptionMessage = networkingResponse.message;
//      _didFetchPopularMovies = false;
//      notifyListeners();
//    }
//
//    /// Stop the loader
//    _isPopularMovieResponseLoading = false;
//    notifyListeners();
//  }
//
//  void _saveMovieToDb(Movies movie) async {
//    print("save movie to db called");
//    int i = await dbHelper.saveMovie(movie.toDatabaseModel());
//    print("new inserted movie rowId is $i");
//  }
//
//  void _savePopularMoviesToDb(PopularMovie popularMovies) async {
//    print("save savePopularMoviesToDb to db called");
//    int i = await dbHelper.savePopularMovies(popularMovies.toDatabaseModel());
//    print("new inserted popular movie rowId is $i");
//  }
//
//  Future<PopularMoviesDatabaseModel> getAllPopularMoviesFromDb() async {
//    List<PopularMoviesDatabaseModel> allPopularMovies = await dbHelper.getAllPopularMovies();
//    this.allPopularMovies = allPopularMovies.first;
//    print("all saved popularMovies are $allPopularMovies");
//    return allPopularMovies.first;
//  }
//
//  Future<MovieDatabaseModel> getAllMoviesFromDb() async {
//    List<MovieDatabaseModel> allMovies = await dbHelper.getAllMovies();
//    print("saved movies to db movies are $allMovies");
//    return allMovies.first;
//  }
//
//  Future<NowPlayingMoviesDatabaseModel> getAllNowPlayingMoviesFromDb() async {
//    List<NowPlayingMoviesDatabaseModel> allNowPlaying = await dbHelper.getAllNowPlaying();
//    this.allNowPlayingMovies = allNowPlaying.first;
//    print("saved nowPlaying movies from db are $allNowPlaying");
//    return allNowPlaying.first;
//  }
//
//  void _saveNowPlayingMoviesToDb(NowPlayingResponse nowPlayingResponse) async {
//    print("_saveNowPlayingMoviesToDb() called");
//    int i = await dbHelper.saveNowPlaying(nowPlayingResponse.toDatabaseModel());
//    print("new inserted nowPlaying movie rowId is $i");
//  }
}
