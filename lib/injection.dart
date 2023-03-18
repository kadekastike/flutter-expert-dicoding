import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/db/tv_database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movies/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movies/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movies/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_on_air.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_reccommendations.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_series/search_tv.dart';
import 'package:ditonton/presentation/bloc/tv/detail_tv/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/on_the_air/tv_on_air_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/provider/movies/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movies/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movies/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/movies/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movies/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movies/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series/watchlist_tv_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TvOnAirBloc(
      locator()
    ),
  );
  locator.registerFactory(
    () => TopRatedTvBloc(
      locator(),
      ),
  );
  locator.registerFactory(
    () => PopularTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvDetailBloc(
      getDetailTv: locator(), 
      getTvRecommendations: locator(), 
      saveWatchlistTV: locator(), 
      removeWatchlistTv: locator(), 
      getTvWatchlistStatus: locator())
    );

  locator.registerFactory(
    () => SearchTvNotifier(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
      getWatchlistTv: locator())
    );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetOnAirTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetDetailTv(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTV(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetTvWatchlistStatus(locator()));


  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      tvRemoteDataSource: locator(),
      tvLocalDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(tvDatabaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => IOClient());
}
