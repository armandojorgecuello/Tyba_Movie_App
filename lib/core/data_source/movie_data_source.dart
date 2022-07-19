import 'package:movie_app/core/api/base_client.dart';
import 'package:movie_app/core/models/movie_model.dart';
import 'package:movie_app/core/models/movies_model.dart';
import 'package:movie_app/core/models/result.dart';

class MoviesDataSource {
  final BaseClient _baseClient;

  MoviesDataSource({
    required BaseClient baseClient,
  }) : _baseClient = baseClient;

  Future<Result<MoviesModel, BackendError> > getMovies() async {
    final result = await _baseClient.makeRequest(
      method: Method.get, 
      path: '/3/movie/popular',
      queryParameters: {
        'api_key' : 'a2b9b179fc3a69a8f981088b4b4d80b1',
        'language': 'es-Es' ,
        'page' : '1'
      }
    );  

    return result.when(
      fail: (fail) => Fail(fail),
      success: (success) => Success((MoviesModel.fromJson(success) ))
    );
  }

  Future<Result<MovieModel, BackendError> > getMovieDetails(String id) async {
    final result = await _baseClient.makeRequest(
      method: Method.get, 
      path: '/3/movie/$id',
      queryParameters: {
        'api_key' : 'a2b9b179fc3a69a8f981088b4b4d80b1',
        'language': 'es-Es' ,
      }
    );  

    return result.when(
      fail: (fail) => Fail(fail),
      success: (success) => Success((MovieModel.fromJson(success) ))
    );
  }

  
}