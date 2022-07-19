
import 'package:movie_app/core/models/movie_model.dart';
import 'package:movie_app/core/models/movies_model.dart';
import 'package:movie_app/core/models/result.dart';

abstract class IMovieRepository {

  Future<Result<MoviesModel, BackendError>>  getmovies();
  Future<Result<MovieModel, BackendError>>  getMovieDetails(String id);

}

