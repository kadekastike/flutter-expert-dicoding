import 'package:ditonton/domain/usecases/tv_series/get_tv_on_air.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_on_air_state.dart';
part 'tv_on_air_event.dart';

class TvOnAirBloc extends Bloc<TvOnAirEvent, TvOnAirState> {
  final GetOnAirTv getOnAirTv;

  TvOnAirBloc(this.getOnAirTv) : super(TvOnAirInitial()) {
    on<LoadOnAirTv>((event, emit) async {
      emit(TvOnAirLoading());
      final result = await getOnAirTv.execute();
      result.fold(
        (failure) => emit(TvOnAirError(failure.message)),
        (tvData) => emit(TvOnAirHasData(tvData)),
      );
    });
  }
}