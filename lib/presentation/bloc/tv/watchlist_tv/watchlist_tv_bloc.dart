import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/tv.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlististTvState> {
  final GetWatchlistTv _getWatchlistTv;

  WatchlistTvBloc(this._getWatchlistTv) : super(WatchlistTvInitial()) {
    on<LoadWatchlistTv>((event, emit) async {
      final result = await _getWatchlistTv.execute();
      result.fold(
        (failure) => emit(WatchlistTvError(failure.message)), 
        (data) {
          if (data.isEmpty) {
            emit(WatchlistTvEmpty("Tidah ada watchlist TV"));
          } else {
            emit(WatchlistTvHasData(data));
          }
        });
    });
  }

}