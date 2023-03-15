import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../domain/entities/tv.dart';

class TvModel extends Equatable {
    TvModel({
        this.backdropPath,
        required this.firstAirDate,
        required this.genreIds,
        required this.id,
        // required this.originalLanguage,
        required this.originalName,
        required this.overview,
        // required this.originCountry,
        required this.posterPath,
        required this.popularity,
        required this.name,
        required this.voteAverage,
        required this.voteCount,
    });

    String? backdropPath;
    String firstAirDate;
    List<int> genreIds;
    int id;
    // OriginalLanguage originalLanguage;
    String originalName;
    String overview;
    // List<OriginCountry> originCountry;
    String? posterPath;
    double popularity;
    String name;
    double voteAverage;
    int voteCount;

    factory TvModel.fromRawJson(String str) => TvModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        backdropPath: json["backdrop_path"],
        firstAirDate: json["first_air_date"] ,
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        // originalLanguage: originalLanguageValues.map[json["original_language"]],
        originalName: json["original_name"],
        overview: json["overview"],
        // originCountry: List<OriginCountry>.from(json["origin_country"].map((x) => originCountryValues.map[x]!)),
        posterPath: json["poster_path"],
        popularity: json["popularity"]?.toDouble(),
        name: json["name"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date": firstAirDate,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        // "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_name": originalName,
        "overview": overview,
        // "origin_country": List<dynamic>.from(originCountry.map((x) => originCountryValues.reverse[x])),
        "poster_path": posterPath,
        "popularity": popularity,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };

    TV toEntity() {
      return TV(
        backdropPath: this.backdropPath,
        firstAirDate: this.firstAirDate,
        genreIds: this.genreIds,
        id: this.id,
        originalName: this.originalName,
        overview: this.overview,
        posterPath: this.posterPath,
        popularity: this.popularity,
        name: this.name,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount
      );
    }
    
      @override
      List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        originalName,
        overview,
        posterPath,
        popularity,
        name,
        voteAverage,
        voteCount
      ];
}

enum OriginCountry { US, GB }

// final originCountryValues = EnumValues({
//     "GB": OriginCountry.GB,
//     "US": OriginCountry.US
// });

// enum OriginalLanguage { EN }

// final originalLanguageValues = EnumValues({
//     "en": OriginalLanguage.EN
// });

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
