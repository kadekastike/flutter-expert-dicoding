import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/movies/search_movies.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies _searchMovies;

  SearchMoviesBloc(this._searchMovies) : super(SearchMoviesInitial()) {
    on<OnQueryChanged>((event, emit) async {
      if (event.query.isEmpty) {
        emit(SearchMoviesInitial());
      } else {
        emit(SearchMoviesLoading());
        final result = await _searchMovies.execute(event.query);
        result.fold(
          (failure) => emit(SearchMoviesError(failure.message)), 
          (data) {
            if (data.isEmpty) {
              emit(SearchMoviesEmpty("Hasil Pencarian tidak ditemukan"));
            } else {
              emit(SearchMoviesHasData(data));
            }
          });
      }
    });
  }

}