import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/dependencies/movies_providers.dart';
import 'package:movie_app/core/models/movies_model.dart';
import 'package:movie_app/core/models/result.dart';
import 'package:movie_app/core/models/result_state.dart';
import 'package:movie_app/ui/screen/home_screen/logic/get_movies_notifier.dart';

final getMoviesNotifierProvider = StateNotifierProvider<
        MoviesNotifier, ResultState<MoviesModel, BackendError>>(
    (ref) => MoviesNotifier(
          moviesUsesCase: ref.watch(moviesUsesCaseProvider),
        ));