import 'package:movie_app/core/data_source/movie_data_source.dart';
import 'package:movie_app/core/models/movie_model.dart';
import 'package:movie_app/core/models/movies_model.dart';
import 'package:movie_app/core/models/result.dart';
import 'package:movie_app/core/repositories/imovies_repository.dart';

class MovieRepository extends IMovieRepository {
  final MoviesDataSource _moviesDataSource;
  
  MovieRepository({
    required MoviesDataSource movieDataSource,
  }) : _moviesDataSource = movieDataSource;  

  @override
  Future<Result<MoviesModel, BackendError>>  getmovies() async {
    final result = await _moviesDataSource.getMovies();

    return result.when(
      fail: (fail) => Fail(fail),
      success: (success) => Success(success),
    );
  }

  @override
  Future<Result<MovieModel, BackendError>> getMovieDetails(String id) async{
    final result = await _moviesDataSource.getMovieDetails(id);

    return result.when(
      fail: (fail) => Fail(fail),
      success: (success) => Success(success),
    );
  }
  

}