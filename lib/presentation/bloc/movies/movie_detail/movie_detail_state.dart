part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];

  get watchlistMessage => null;
}
class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movieDetail;
  final List<Movie> movieRecommendations;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const MovieDetailHasData({ 
    required this.movieDetail,
    this.movieRecommendations = const [],
    required this.watchlistMessage,
    this.isAddedToWatchlist = false });

  @override
  List<Object> get props => [
    movieDetail,
    movieRecommendations,
    watchlistMessage,
    isAddedToWatchlist
  ];
}