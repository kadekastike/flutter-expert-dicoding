import 'package:ditonton/domain/usecases/tv_series/get_popular_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/tv.dart';
part 'popular_tv_state.dart';
part 'popular_tv_event.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv getPopularTv;

  PopularTvBloc(this.getPopularTv) : super(PopularTvInitial()) {
    on<LoadPopularTv>((event, emit) async {
      emit(PopularTvLoading());
      final popularTv = await getPopularTv.execute();
      popularTv.fold(
        (failure) => emit(PopularTvError(failure.message)),
        (tvData) => emit(PopularTvHasData(tvData)),
      );
    });
  }
}