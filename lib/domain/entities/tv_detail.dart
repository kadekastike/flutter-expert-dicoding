import 'package:ditonton/data/models/genre_model.dart';
import 'package:equatable/equatable.dart';

import 'genre.dart';

class TvDetail extends Equatable {
    TvDetail({
        required this.backdropPath,
        required this.episodeRunTime,
        required this.firstAirDate,
        required this.genres,
        required this.homepage,
        required this.id,
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
        required this.voteAverage,
        required this.voteCount,
    });

    String backdropPath;
    List<int> episodeRunTime;
    DateTime firstAirDate;
    List<Genre> genres;
    String homepage;
    int id;
    List<String> languages;
    DateTime lastAirDate;
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
    double voteAverage;
    int voteCount;
    
      @override
            List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
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