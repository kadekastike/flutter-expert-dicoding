part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];

  get watchlistMessage => null;
}

class TvDetailInitial extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailError extends TvDetailState {
  final String message;

  const TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailHasData extends TvDetailState {
  final TvDetail tvDetail;
  final List<TV> tvRecommendations;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const TvDetailHasData({ 
    required this.tvDetail,
    this.tvRecommendations = const [],
    required this.watchlistMessage,
    this.isAddedToWatchlist = false });

  @override
  List<Object> get props => [
    tvDetail,
    tvRecommendations,
    watchlistMessage,
    isAddedToWatchlist
  ];
}