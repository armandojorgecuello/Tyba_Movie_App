import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/dependencies/movies_providers.dart';
import 'package:movie_app/core/models/movie_model.dart';
import 'package:movie_app/core/models/result.dart';
import 'package:movie_app/core/models/result_state.dart';
import 'package:movie_app/ui/screen/movie_details_screen/logic/get_movies_details_notifier.dart';

final getMovieNotifierProvider = StateNotifierProvider<
        MovieNotifier, ResultState<MovieModel, BackendError>>(
    (ref) => MovieNotifier(
          movieUsesCase: ref.watch(movieUsesCaseProvider),
        ));