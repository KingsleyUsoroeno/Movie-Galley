import 'package:data/model/popular_movie_entity.dart';
import 'package:data/model/result_entity.dart';
import 'package:domain/model/popular_movie.dart';
import 'package:domain/model/result.dart';

import 'base/entity_mapper.dart';

class PopularMovieEntityMapper
    extends EntityMapper<PopularMovieEntity, PopularMovie> {
  @override
  PopularMovie mapFromEntity(PopularMovieEntity entity) {
    return PopularMovie(
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
  PopularMovieEntity mapToEntity(PopularMovie domain) {
    return PopularMovieEntity(
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

  List<PopularMovie> mapFromEntityList(List<PopularMovieEntity> movieEntity) {
    return movieEntity.map((e) => mapFromEntity(e)).toList();
  }
}
