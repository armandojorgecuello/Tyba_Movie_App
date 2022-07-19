import 'dart:convert';

import 'package:movie_app/core/models/movie_model.dart';


MoviesModel userDataMoldeFromJson(String str) => MoviesModel.fromJson(json.decode(str));

String userDataMoldeToJson(MoviesModel data) => json.encode(data.toJson());

class MoviesModel {
    MoviesModel({
        this.page,
        this.results,
    });

    int? page;
    List<MovieModel>? results;

    factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
        page: ((json['page'] ?? 0) as num).toInt(),
        results:((json['results'] ?? []) as List)
          .map((v) => MovieModel.fromJson(v))
          .toList(),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

