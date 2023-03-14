import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/tv.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  final GetWatchlistTv getWatchlistTv;

  WatchlistTvNotifier({ required this.getWatchlistTv});

  var _watchlistTv = <TV>[];
  List<TV> get watchlistTv => _watchlistTv;

  RequestState _watchlistTvState = RequestState.Empty;
  RequestState get watchlistTvState => _watchlistTvState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistTv() async {
    _watchlistTvState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTv.execute();
    result.fold(
      (failure) {
        _watchlistTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (watchlistData) {
        _watchlistTvState = RequestState.Loaded;
        _watchlistTv = watchlistData;
        notifyListeners();
      }
    );
  }
}