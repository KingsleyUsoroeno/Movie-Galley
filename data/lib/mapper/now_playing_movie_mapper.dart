import 'package:data/model/now_playing_movie_entity.dart';
import 'package:data/model/result_entity.dart';
import 'package:domain/model/now_playing_movie.dart';
import 'package:domain/model/result.dart';

import 'base/entity_mapper.dart';

class NowPlayingMovieMapper
    extends EntityMapper<NowPlayingMovieEntity, NowPlayingMovie> {
  @override
  NowPlayingMovie mapFromEntity(NowPlayingMovieEntity entity) {
    return NowPlayingMovie(
      page: entity.page,
      totalPages: entity.totalPages,
      totalResults: entity.totalResults,
      results: entity.results
          .map((e) => MovieResult(
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
  NowPlayingMovieEntity mapToEntity(NowPlayingMovie domain) {
    return NowPlayingMovieEntity(
      page: domain.page,
      totalPages: domain.totalPages,
      totalResults: domain.totalResults,
      results: domain.results
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

  List<NowPlayingMovie> mapFromEntityList(
      List<NowPlayingMovieEntity> movieEntity) {
    return movieEntity.map((e) => mapFromEntity(e)).toList();
  }
}
