import 'dart:convert';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/tv_detail.dart';

class TvDetailResponse extends Equatable{
    TvDetailResponse({
        required this.backdropPath,
        required this.episodeRunTime,
        required this.firstAirDate,
        required this.genres,
        required this.homepage,
        required this.id,
        required this.inProduction,
        required this.languages,
        required this.lastAirDate,
        required this.name,
        this.nextEpisodeToAir,
        required this.numberOfEpisodes,
        required this.numberOfSeasons,
        required this.originCountry,
        required this.originalLanguage,
        required this.originalName,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.status,
        required this.tagline,
        required this.type,
        required this.voteAverage,
        required this.voteCount,
    });

    String backdropPath;
    List<int> episodeRunTime;
    String firstAirDate;
    List<GenreModel> genres;
    String homepage;
    int id;
    bool inProduction;
    List<String> languages;
    String lastAirDate;
    String name;
    dynamic nextEpisodeToAir;
    int numberOfEpisodes;
    int numberOfSeasons;
    List<String> originCountry;
    String originalLanguage;
    String originalName;
    String overview;
    double popularity;
    String posterPath;
    String status;
    String tagline;
    String type;
    double voteAverage;
    int voteCount;

    factory TvDetailResponse.fromRawJson(String str) => TvDetailResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TvDetailResponse.fromJson(Map<String, dynamic> json) => TvDetailResponse(
        backdropPath: json["backdrop_path"],
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: json["first_air_date"],
        genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: json["last_air_date"],
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "last_air_date": lastAirDate,
        "name": name,
        "next_episode_to_air": nextEpisodeToAir,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };

    TvDetail toEntity() {
      return TvDetail(
        backdropPath: this.backdropPath, 
        episodeRunTime: this.episodeRunTime, 
        firstAirDate: this.firstAirDate, 
        genres: this.genres.map((genre) => genre.toEntity()).toList(),
        homepage: this.homepage, 
        id: this.id, 
        languages: this.languages, 
        lastAirDate: this.lastAirDate, 
        name: this.name, 
        numberOfEpisodes: this.numberOfEpisodes, 
        numberOfSeasons: this.numberOfSeasons, 
        originCountry: this.originCountry, 
        originalLanguage: this.originalLanguage, 
        originalName: this.originalName, 
        overview: this.overview, 
        popularity: this.popularity, 
        posterPath: this.posterPath, 
        voteAverage: this.voteAverage, 
        voteCount: this.voteCount
        );
    }
    
      @override
      List<Object?> get props => [
        backdropPath,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        languages,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount
      ];
}
