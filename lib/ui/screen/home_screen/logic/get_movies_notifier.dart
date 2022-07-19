import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/models/movies_model.dart';
import 'package:movie_app/core/models/result.dart';
import 'package:movie_app/core/models/result_state.dart';
import 'package:movie_app/core/use_case/movies_uses_case.dart';

class MoviesNotifier extends StateNotifier<ResultState<MoviesModel, BackendError>> {
  MoviesNotifier({
    required MoviesUsesCase moviesUsesCase,
  })  : _moviesUsesCase = moviesUsesCase,
        super(ResultState.initial());
  final MoviesUsesCase _moviesUsesCase;

  Future  movies() async {
    state = ResultState.loading();
    final response = await _moviesUsesCase.call();
        
state = response.when(
      fail: (fail) => ResultState.error(fail),
      success: (success) => ResultState.data(success),
    );
  }
}