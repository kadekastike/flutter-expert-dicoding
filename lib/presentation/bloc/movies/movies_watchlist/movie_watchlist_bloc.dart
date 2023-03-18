import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/movies/get_watchlist_movies.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;

  MovieWatchlistBloc(this.getWatchlistMovies) : super(MovieWatchlistInitial()) {
    on<LoadMovieWatchlist>((event, emit) async {
      emit(MovieWatchlistLoading());
      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(MovieWatchlistError(failure.message)), 
        (data) => {
          if (data.isEmpty) {
            emit(MovieWatchlistEmpty('Tidak Ada watchlist Movie'))
          } else {
            emit(MovieWatchlistHasData(data))
          }
        });
    });
  }

}