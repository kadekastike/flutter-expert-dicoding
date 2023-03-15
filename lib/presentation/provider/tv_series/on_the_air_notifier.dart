import 'package:ditonton/domain/usecases/tv_series/get_tv_on_air.dart';
import 'package:flutter/foundation.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv.dart';

class OnTheAirNotifier extends ChangeNotifier {
  final GetOnAirTv getOnAirTv;

  OnTheAirNotifier({ required this.getOnAirTv});

  List<TV> _onTheAirTv = [];
  List<TV> get onTheAir => _onTheAirTv;

  RequestState _onTheAirTvState= RequestState.Empty;
  RequestState get onTheAirTvState => _onTheAirTvState;

  String _message = '';
  String get message => _message;

    Future<void> fetchOnTheAirTv() async {
    _onTheAirTvState = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTv.execute();
    result.fold(
      (failure) {
        _onTheAirTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (popularData) {
        _onTheAirTvState = RequestState.Loaded;
        _onTheAirTv = popularData;
        notifyListeners();
      });
  }
}