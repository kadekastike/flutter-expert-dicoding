import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_reccommendations.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv.dart';
import 'package:flutter/material.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  
  final GetDetailTv getDetailTv;
  final GetTvRecommendations getTvRecommendations;
  final GetTvWatchlistStatus getTvWatchlistStatus;
  final SaveWatchlistTV saveWatchlistTV;
  final RemoveWatchlistTv removeWatchlistTv;

  TvDetailNotifier({ 
    required this.getDetailTv,
    required this.getTvRecommendations,
    required this.getTvWatchlistStatus,
    required this.saveWatchlistTV,
    required this.removeWatchlistTv,
  });

  late TvDetail _detailTv;
  TvDetail get detailTv => _detailTv;

  RequestState _tvDetailState = RequestState.Empty;
  RequestState get tvDetailState => _tvDetailState;

  late List<TV> _tvRecommendations = [];
  List<TV> get tvRecommendations => _tvRecommendations;

  RequestState _tvRecommendationsState = RequestState.Empty;
  RequestState get tvRecommendationsState => _tvRecommendationsState;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvDetail(id) async {
    _tvDetailState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getDetailTv.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvDetailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (tvDetailData) {
        _tvDetailState = RequestState.Loading;
        _detailTv = tvDetailData;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _tvRecommendationsState = RequestState.Error;
            _message = failure.message;
            notifyListeners();
          }, 
          (recommendationData) {
            _tvRecommendationsState = RequestState.Loaded;
            _tvRecommendations = recommendationData;
          }
          );
        _tvDetailState = RequestState.Loaded;
        notifyListeners();
      });
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvDetail tvDetail) async {
    final result = await saveWatchlistTV.execute(tvDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvDetail.id);
  }

  Future<void> removeFromWatchlist(TvDetail tvDetail) async {
    final result = await removeWatchlistTv.execute(tvDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvDetail.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getTvWatchlistStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}