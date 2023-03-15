import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/tv/dummy_data.dart';
import '../../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetDetailTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetDetailTv(mockTvRepository);
  });

  final tId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvDetail(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvDetail));
  });
}
