part of 'search_movies_bloc.dart';

abstract class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object> get props => [];
}

class SearchMoviesInitial extends SearchMoviesState {}

class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesError extends SearchMoviesState {
  final String message;

  const SearchMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMoviesEmpty extends SearchMoviesState {
  final String message;

  const SearchMoviesEmpty(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMoviesHasData extends SearchMoviesState {
  final List<Movie> movie;

  const SearchMoviesHasData(this.movie);

  @override
  List<Object> get props => [movie];
}