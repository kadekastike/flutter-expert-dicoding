part of 'watchlist_tv_bloc.dart';

abstract class WatchlististTvState extends Equatable {
  const WatchlististTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTvInitial extends WatchlististTvState {}

class WatchlistTvLoading extends WatchlististTvState {}

class WatchlistTvError extends WatchlististTvState {
  final String message;

  const WatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvEmpty extends WatchlististTvState {
  final String message;

  const WatchlistTvEmpty(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvHasData extends WatchlististTvState {
  final List<TV> tv;

  const WatchlistTvHasData(this.tv);

  @override
  List<Object> get props => [tv];

}