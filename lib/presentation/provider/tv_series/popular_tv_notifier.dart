import 'package:flutter/material.dart';
import '../../../common/state_enum.dart';
import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/tv_series/get_popular_tv.dart';

class PopularTvNotifier extends ChangeNotifier {
  final GetPopularTv getPopularTv;

  PopularTvNotifier({ required this.getPopularTv});

  List<TV> _popularTv = [];
  List<TV> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  String _message = '';
  String get message => _message;

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
}