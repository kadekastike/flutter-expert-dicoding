import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_on_air.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  final GetOnAirTv getOnAirTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  TvListNotifier({
    required this.getOnAirTv,
    required this.getPopularTv,
    required this.getTopRatedTv
  });

  var _onAirTv = <TV>[];
  List<TV> get onAirTv => _onAirTv;

  RequestState _onAirTvState = RequestState.Empty;
  RequestState get onAirTvState => _onAirTvState;

  var _popularTv = <TV>[];
  List<TV> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  var _topRatedTv = <TV>[];
  List<TV> get topRatedTv => _topRatedTv;

  RequestState _topRatedTvState = RequestState.Empty;
  RequestState get topRatedTvState => _topRatedTvState;

  String _message = '';
  String get message => _message;


  Future<void> fetchOnAirTv() async {
    _onAirTvState = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTv.execute();
    result.fold(
      (failure) {
        _onAirTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (tvData) {
        _onAirTvState = RequestState.Loaded;
        _onAirTv = tvData;
        notifyListeners();
      });
  }

  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        _popularTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (popularData) {
        _popularTvState = RequestState.Loaded;
        _popularTv = popularData;
        notifyListeners();
      });
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTvState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) {
       _topRatedTvState = RequestState.Loading;
       _message = failure.message;
       notifyListeners(); 
      }, 
    (topRatedTvData) {
      _topRatedTvState = RequestState.Loaded;
      _topRatedTv = topRatedTvData;
      notifyListeners();
    });
  }
}