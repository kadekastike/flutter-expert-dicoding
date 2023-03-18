part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable { 
  const TvDetailEvent();
  
  @override
  List<Object?> get props => [];
}

class LoadTvDetail extends TvDetailEvent {
  final int id;

  LoadTvDetail(this.id);

}

class AddToTvWatchlist extends TvDetailEvent {
  final TvDetail tvDetail;
  final List<TV> tvRecommendations;
  const AddToTvWatchlist(this.tvDetail, this.tvRecommendations);
}

class RemoveFromTvWatchlist extends TvDetailEvent {
  final TvDetail tvDetail;
  final List<TV> tvRecommendations;
  const RemoveFromTvWatchlist(this.tvDetail, this.tvRecommendations);
}