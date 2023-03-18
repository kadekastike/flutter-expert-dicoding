import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_reccommendations.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/tv_detail.dart';
part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetDetailTv getDetailTv;
  final GetTvRecommendations getTvRecommendations;
  final SaveWatchlistTV saveWatchlistTV;
  final RemoveWatchlistTv removeWatchlistTv;
  final GetTvWatchlistStatus getTvWatchlistStatus;

  TvDetailBloc({
    required this.getDetailTv,
    required this.getTvRecommendations,
    required this.saveWatchlistTV,
    required this.removeWatchlistTv,
    required this.getTvWatchlistStatus}) : super(TvDetailInitial()) {
    on<LoadTvDetail>((event, emit) async {
      emit(TvDetailLoading());
      final detailResult = await getDetailTv.execute(event.id);
      final tvRecommendations = await getTvRecommendations.execute(event.id);
      final isAddedToWatchlistStatus = await getTvWatchlistStatus.execute(event.id);
      detailResult.fold(
        (failure) => emit(TvDetailError(failure.message)), 
        (data) {
          tvRecommendations.fold(
            (failure) => emit(TvDetailError(failure.message)), 
            (tvRecommendationData) {
              emit(TvDetailHasData(
                tvDetail: data,
                tvRecommendations: tvRecommendationData,
                isAddedToWatchlist: isAddedToWatchlistStatus,
                watchlistMessage: '',
                ));
            } );
        });
    });

    on<AddToTvWatchlist>((event, emit) async {
      final data = await saveWatchlistTV.execute(event.tvDetail);
      await data.fold(
        (failure) async {
          emit(TvDetailHasData(
            tvDetail: event.tvDetail,
            tvRecommendations: event.tvRecommendations,
            watchlistMessage: failure.message,
            isAddedToWatchlist: false));
        }, 
        (message) async {
          emit(TvDetailHasData(
            tvDetail: event.tvDetail,
            tvRecommendations: event.tvRecommendations,
            watchlistMessage: message,
            isAddedToWatchlist: true));
        });
    });

    on<RemoveFromTvWatchlist>((event, emit) async {
      final data = await removeWatchlistTv.execute(event.tvDetail);
      await data.fold(
        (failure) async {
          emit(TvDetailHasData(
            tvDetail: event.tvDetail,
            tvRecommendations: event.tvRecommendations,
            watchlistMessage: failure.message,
            isAddedToWatchlist: true));
        }, 
        (message) async {
          emit(TvDetailHasData(
            tvDetail: event.tvDetail,
            tvRecommendations: event.tvRecommendations,
            watchlistMessage: message,
            isAddedToWatchlist: false));
        });
    });
  }

}