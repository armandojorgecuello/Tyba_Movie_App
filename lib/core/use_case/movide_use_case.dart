import 'package:movie_app/core/data_source/movie_data_source.dart';
import 'package:movie_app/core/models/movie_model.dart';
import 'package:movie_app/core/models/result.dart';

class MovieUsesCase {
  MovieUsesCase({
    required MoviesDataSource moviesDataSource,
  }) : _moviesDataSource = moviesDataSource;

  final MoviesDataSource _moviesDataSource;

  Future<Result<MovieModel, BackendError>> call(String id) => _moviesDataSource.getMovieDetails(id);
}