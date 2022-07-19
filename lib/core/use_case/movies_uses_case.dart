import 'package:movie_app/core/data_source/movie_data_source.dart';
import 'package:movie_app/core/models/movies_model.dart';
import 'package:movie_app/core/models/result.dart';

class MoviesUsesCase {
  MoviesUsesCase({
    required MoviesDataSource moviesDataSource,
  }) : _moviesDataSource = moviesDataSource;

  final MoviesDataSource _moviesDataSource;

  Future<Result<MoviesModel, BackendError>> call() => _moviesDataSource.getMovies();
}