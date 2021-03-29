import 'package:cache/imports/module_imports.dart';
import 'package:cache/mapper/base/cache_model_mapper.dart';
import 'package:cache/models/cache_now_playing_movies.dart';

class CacheNowPlayingMovieMapper
    implements CacheModelMapper<CacheNowPlayingMovie, NowPlayingMovieEntity> {
  @override
  NowPlayingMovieEntity mapToEntity(CacheNowPlayingMovie model) {
    return NowPlayingMovieEntity(
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
  CacheNowPlayingMovie mapToModel(NowPlayingMovieEntity entity) {
    return CacheNowPlayingMovie(
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
