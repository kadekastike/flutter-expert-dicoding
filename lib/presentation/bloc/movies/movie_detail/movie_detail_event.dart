part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadDetailMovie extends MovieDetailEvent {
  final int id;

  const LoadDetailMovie(this.id);
}

class AddToMovieWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;
  final List<Movie> movieRecommendations;
  const AddToMovieWatchlist(this.movieDetail, this.movieRecommendations);
}

class RemoveFromMovieWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;
  final List<Movie> movieRecommendations;
  const RemoveFromMovieWatchlist(this.movieDetail, this.movieRecommendations);
}