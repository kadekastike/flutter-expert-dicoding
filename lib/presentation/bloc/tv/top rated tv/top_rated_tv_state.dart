part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();
  @override
  List<Object> get props => [];
}

class TopRatedTvInitial extends TopRatedTvState{}

class TopRatedTvLoading extends TopRatedTvState{}

class TopRatedTvError extends TopRatedTvState {
  final String message;
  
  const TopRatedTvError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvHasData extends TopRatedTvState {
  final List<TV> topRatedTvData;

  const TopRatedTvHasData(this.topRatedTvData);

  @override
  List<Object> get props => [topRatedTvData];
}