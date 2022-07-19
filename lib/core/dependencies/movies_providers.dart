import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/data_source/movie_data_source.dart';
import 'package:movie_app/core/dependencies/api_providers.dart';
import 'package:movie_app/core/use_case/movide_use_case.dart';
import 'package:movie_app/core/use_case/movies_uses_case.dart';

final moviesDataSourceProvider = Provider((ref) => MoviesDataSource(
      baseClient: ref.watch(movieProvider),
    ));

final moviesUsesCaseProvider = Provider((ref) => MoviesUsesCase(
      moviesDataSource: ref.watch(moviesDataSourceProvider),
    ));

final movieUsesCaseProvider = Provider((ref) => MovieUsesCase(
      moviesDataSource: ref.watch(moviesDataSourceProvider),
    ));