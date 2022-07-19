import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/models/movie_model.dart';
import 'package:movie_app/core/models/result.dart';
import 'package:movie_app/core/models/result_state.dart';
import 'package:movie_app/core/use_case/movide_use_case.dart';

class MovieNotifier extends StateNotifier<ResultState<MovieModel, BackendError>> {
  MovieNotifier({
    required MovieUsesCase movieUsesCase,
  })  : _movieUsesCase = movieUsesCase,
        super(ResultState.initial());
  final MovieUsesCase _movieUsesCase;

  Future  movieDetail(String id) async {
    state = ResultState.loading();
    final response = await _movieUsesCase.call(id);
        
state = response.when(
      fail: (fail) => ResultState.error(fail),
      success: (success) {
        return ResultState.data(success);
      },
    );
  }
}