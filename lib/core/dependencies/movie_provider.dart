import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/models/movie_model.dart';

final movieFilterProvider = StateProvider<List<MovieModel>>(((ref) => [] ));