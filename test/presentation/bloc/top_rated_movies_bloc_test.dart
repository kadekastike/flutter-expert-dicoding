import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movies/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_bloc_test.mocks.dart';


@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesBloc topRatedMoviesBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test('Initial state should be empty', () {
    expect(topRatedMoviesBloc.state, TopRatedMoviesInitial());
  });

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'Should emit [Loading, HasData] when successfully get data',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(LoadTopRatedMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(LoadTopRatedMovies()),
    wait: Duration(milliseconds: 500),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesError('Server Failure'),
    ],
    verify: (bloc) => mockGetTopRatedMovies.execute(),
  );
}
