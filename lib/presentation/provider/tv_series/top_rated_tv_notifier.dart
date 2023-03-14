import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv.dart';
import 'package:flutter/material.dart';
import '../../../common/state_enum.dart';
import '../../../domain/entities/tv.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvNotifier({ required this.getTopRatedTv});

  List<TV> _topRatedTv = [];
  List<TV> get topRatedTv => _topRatedTv;

  RequestState _topRatedTvState = RequestState.Empty;
  RequestState get topRatedTvState => _topRatedTvState;


  String _message = '';
  String get message => _message;

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