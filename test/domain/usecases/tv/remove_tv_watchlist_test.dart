import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/tv/dummy_data.dart';
import '../../../helpers/tv_test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTv usecase;
  late MockTvRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTvRepository();
    usecase = RemoveWatchlistTv(mockMovieRepository);
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockMovieRepository.removeTvWatchlist(testTvDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockMovieRepository.removeTvWatchlist(testTvDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
