import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movies/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movies/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/movies/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchListStatus;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchListStatus
  }) : super(MovieDetailInitial()) {
    on<LoadDetailMovie>((event, emit) async {
      emit(MovieDetailLoading());
      final result = await getMovieDetail.execute(event.id);
      final recommendations = await getMovieRecommendations.execute(event.id);
      final isAddedToWatchlist = await getWatchListStatus.execute(event.id);
      result.fold(
        (failure) => emit(MovieDetailError(failure.message)), 
        (data) {
          recommendations.fold(
            (failure) => emit(MovieDetailError(failure.message)), 
            (recommendationData) {
              emit(MovieDetailHasData(
                movieDetail: data, 
                movieRecommendations: recommendationData,
                isAddedToWatchlist: isAddedToWatchlist,
                watchlistMessage: ''));
            });
        });
    });
    on<AddToMovieWatchlist>((event, emit) async {
      final data = await saveWatchlist.execute(event.movieDetail);
      await data.fold(
        (failure) async {
          emit(MovieDetailHasData(
            movieDetail: event.movieDetail,
            movieRecommendations: event.movieRecommendations,
            watchlistMessage: failure.message,
            isAddedToWatchlist: false));
        }, 
        (message) async {
          emit(MovieDetailHasData(
            movieDetail: event.movieDetail,
            movieRecommendations: event.movieRecommendations,
            watchlistMessage: message,
            isAddedToWatchlist: true));
        });
    });

    on<RemoveFromMovieWatchlist>((event, emit) async {
      final data = await removeWatchlist.execute(event.movieDetail);
      await data.fold(
        (failure) async {
          emit(MovieDetailHasData(
            movieDetail: event.movieDetail,
            movieRecommendations: event.movieRecommendations,
            watchlistMessage: failure.message,
            isAddedToWatchlist: true));
        }, 
        (message) async {
          emit(MovieDetailHasData(
            movieDetail: event.movieDetail,
            movieRecommendations: event.movieRecommendations,
            watchlistMessage: message,
            isAddedToWatchlist: false));
        });
    });
  }
}