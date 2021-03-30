import 'package:cache/imports/module_imports.dart';
import 'package:cache/mapper/base/cache_model_mapper.dart';
import 'package:cache/models/cache_popular_movie.dart';

class CachePopularMovieMapper
    extends CacheModelMapper<CachePopularMovie, PopularMovieEntity> {
  @override
  PopularMovieEntity mapToEntity(CachePopularMovie model) {
    return PopularMovieEntity(
      totalPages: model.totalPages,
      totalResults: model.totalResults,
      results: model.results
          .map((e) => ResultEntity(
              popularity: e.popularity,
              voteCount: e.voteCount,
              video: e.video,
              posterPath: e.posterPath,
              id: e.id,
              adult: e.adult,
              backdropPath: e.backdropPath,
              originalLanguage: e.originalLanguage,
              originalTitle: e.originalTitle,
              genreIds: e.genreIds,
              title: e.title,
              overview: e.overview,
              releaseDate: e.releaseDate))
          .toList(),
    );
  }

  @override
  CachePopularMovie mapToModel(PopularMovieEntity entity) {
    return CachePopularMovie(
        totalPages: entity.totalPages,
        totalResults: entity.totalResults,
        results: entity.results
            .map((e) => CacheMovieResult(
                popularity: e.popularity,
                voteCount: e.voteCount,
                video: e.video,
                posterPath: e.posterPath,
                id: e.id,
                adult: e.adult,
                backdropPath: e.backdropPath,
                originalLanguage: e.originalLanguage,
                originalTitle: e.originalTitle,
                genreIds: e.genreIds,
                title: e.title,
                overview: e.overview,
                releaseDate: e.releaseDate))
            .toList());
  }
}
