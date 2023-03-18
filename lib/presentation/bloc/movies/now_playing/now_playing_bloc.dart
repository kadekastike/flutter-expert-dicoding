import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_state.dart';
part 'now_playing_event.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingBloc(this._getNowPlayingMovies) : super(NowPlayingInitial()) {
    on<LoadNowPlayingMovie>((event, emit) async {
      emit(NowPlayingLoading());
      final result = await _getNowPlayingMovies.execute();
      result.fold(
        (failure) => emit(NowPlayingError(failure.message)),
        (tvData) => emit(NowPlayingHasData(tvData)),
      );
    });
  }
}