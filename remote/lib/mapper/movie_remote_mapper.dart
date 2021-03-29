import 'package:data/model/movie_entity.dart';
import 'package:data/model/result_entity.dart';
import 'package:remote/models/response/movie_remote_model.dart';

import 'base/remote_model_mapper.dart';

class MovieRemoteMapper
    extends RemoteModelMapper<MovieRemoteModel, MovieEntity> {
  @override
  MovieEntity mapFromModel(MovieRemoteModel model) {
    return MovieEntity(
      page: model.page,
      totalResults: model.totalResults,
      totalPages: model.totalPages,
      results: model.results != null
          ? model.results
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
                ),
              )
              .toList()
          : [],
    );
  }
}
