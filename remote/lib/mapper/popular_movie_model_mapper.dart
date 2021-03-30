import 'package:data/model/popular_movie_entity.dart';
import 'package:data/model/result_entity.dart';
import 'package:remote/mapper/base/remote_model_mapper.dart';
import 'package:remote/models/response/popular_movie_response.dart';

class PopularMovieModelMapper
    extends RemoteModelMapper<PopularMovieResponse, PopularMovieEntity> {
  @override
  PopularMovieEntity mapFromModel(PopularMovieResponse model) {
    return PopularMovieEntity(
      page: model.page,
      totalResults: model.totalResults,
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
                    releaseDate: e.releaseDate ?? ""),
              )
              .toList()
          : [],
    );
  }
}
