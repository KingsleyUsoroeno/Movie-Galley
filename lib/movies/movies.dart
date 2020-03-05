import 'package:movies/movies/Result.dart';

class Movies {
  int _page;
  int _totalResults;
  int _totalPages;
  List<Results> _results;

  Movies({int page, int totalResults, int totalPages, List<Results> results}) {
    this._page = page;
    this._totalResults = totalResults;
    this._totalPages = totalPages;
    this._results = results;
  }

  int get page => _page;

  set page(int page) => _page = page;

  int get totalResults => _totalResults;

  set totalResults(int totalResults) => _totalResults = totalResults;

  int get totalPages => _totalPages;

  set totalPages(int totalPages) => _totalPages = totalPages;

  List<Results> get results => _results;

  set results(List<Results> results) => _results = results;

  Movies.fromJson(Map<String, dynamic> json) {
    _page = json['page'];
    _totalResults = json['total_results'];
    _totalPages = json['total_pages'];
    if (json['results'] != null) {
      _results = new List<Results>();
      json['results'].forEach((v) {
        _results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this._page;
    data['total_results'] = this._totalResults;
    data['total_pages'] = this._totalPages;
    if (this._results != null) {
      data['results'] = this._results.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Movies{_page: $_page, _totalResults: $_totalResults, _totalPages: $_totalPages, _results: $_results}';
  }
}
