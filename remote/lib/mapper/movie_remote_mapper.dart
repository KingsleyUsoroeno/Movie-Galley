import 'package:data/model/movie_entity.dart';
import 'package:data/model/result_entity.dart';
import 'package:remote/models/movie_dto.dart';

import 'base/remote_model_mapper.dart';

class MovieRemoteMapper extends RemoteModelMapper<MovieDTO, MovieEntity> {
  @override
  MovieEntity mapFromModel(MovieDTO model) {
    return MovieEntity(
        id: null,
        page: model.page,
        totalResults: model.totalResults,
        totalPages: model.totalPages,
        results: model.movieResults
            .map(
              (e) => ResultEntity(
                  popularity: e.popularity ?? 0,
                  voteCount: e.voteCount ?? 0,
                  video: e.video ?? false,
                  posterPath: e.posterPath ?? "",
                  id: e.id ?? 0,
                  backdropPath: e.backdropPath ?? "",
                  originalLanguage: e.originalLanguage ?? "",
                  originalTitle: e.originalTitle ?? "",
                  genreIds: e.genreIds ?? [],
                  title: e.title ?? "",
                  overview: e.overview ?? "",
                  releaseDate: e.releaseDate ?? "",
                  adult: e.adult),
            )
            .toList());
  }
}
