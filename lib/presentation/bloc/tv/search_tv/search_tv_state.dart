part of 'search_tv_bloc.dart';

abstract class SearchTvState extends Equatable {
  const SearchTvState();

  @override
  List<Object> get props => [];

}

class SearchTvInitial extends SearchTvState {}

class SearchTvLoading extends SearchTvState {}

class SearchTvError extends SearchTvState {
  final String message;

  const SearchTvError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvEmpty extends SearchTvState {
  final String message;

  const SearchTvEmpty(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvHasData extends SearchTvState {
  final List<TV> tv;

  const SearchTvHasData(this.tv);

  @override
  List<Object> get props => [tv];
}