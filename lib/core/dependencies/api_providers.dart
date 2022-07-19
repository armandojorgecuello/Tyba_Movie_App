import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/api/base_client.dart';

final clientProvider = Provider((ref) => Dio());

final movieProvider = Provider(
  (ref) => BaseClient(
    client: ref.watch(clientProvider),
    host: 'api.themoviedb.org',
  ),
);
