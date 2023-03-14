import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_reccommendations.dart';
import 'package:flutter/material.dart';

class TvDetailNotifier extends ChangeNotifier {
  final GetDetailTv getDetailTv;
  final GetTvRecommendations getTvRecommendations;

  TvDetailNotifier({ 
    required this.getDetailTv,
    required this.getTvRecommendations
  });

  late TvDetail _detailTv;
  TvDetail get detailTv => _detailTv;

  RequestState _tvDetailState = RequestState.Empty;
  RequestState get tvDetailState => _tvDetailState;

  late List<TV> _tvRecommendations = [];
  List<TV> get tvRecommendations => _tvRecommendations;

  RequestState _tvRecommendationsState = RequestState.Empty;
  RequestState get tvRecommendationsState => _tvRecommendationsState;

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
}