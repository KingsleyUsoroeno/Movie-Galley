import 'package:data/model/date_entity.dart';
import 'package:data/model/now_playing_movie_entity.dart';
import 'package:data/model/result_entity.dart';
import 'package:remote/mapper/base/remote_model_mapper.dart';
import 'package:remote/models/response/now_playing_movie_response.dart';

class NowPlayingMovieRemoteMapper
    extends RemoteModelMapper<NowPlayingMovieResponse, NowPlayingMovieEntity> {
  @override
  NowPlayingMovieEntity mapFromModel(NowPlayingMovieResponse model) {
    return NowPlayingMovieEntity(
      page: model.page,
      totalResults: model.totalResults,
      dates: DateEntity(
          maximum: model.dates.maximum, minimum: model.dates.minimum),
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
