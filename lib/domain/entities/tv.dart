import 'package:equatable/equatable.dart';

class TV extends Equatable {
    TV({
        required this.backdropPath,
        required this.firstAirDate,
        required this.genreIds,
        required this.id,
        required this.originalName,
        required this.overview,
        required this.posterPath,
        required this.popularity,
        required this.name,
        required this.voteAverage,
        required this.voteCount,
    });

    TV.watchlist({
      required this.id,
      required this.overview,
      required this.posterPath,
      required this.name
    });

    String? backdropPath;
    DateTime? firstAirDate;
    List<int>? genreIds;
    int? id;
    String? originalName;
    String? overview;
    String? posterPath;
    double? popularity;
    String? name;
    double? voteAverage;
    int? voteCount;
    
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
    