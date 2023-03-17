import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/tv.dart';
part 'top_rated_tv_state.dart';
part 'top_rated_tv_event.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvBloc(this.getTopRatedTv) : super(TopRatedTvInitial()) {
    on<LoadTopRatedTv>((event, emit) async {
      emit(TopRatedTvLoading());
      final topRatedTv = await getTopRatedTv.execute();
      topRatedTv.fold(
        (failure) => emit(TopRatedTvError(failure.message)),
        (tvData) => emit(TopRatedTvHasData(tvData)),
      );
    });
  }
}