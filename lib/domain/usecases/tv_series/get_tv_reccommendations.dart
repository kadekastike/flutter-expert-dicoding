import 'package:dartz/dartz.dart';
import '../../../common/failure.dart';
import '../../entities/tv.dart';
import '../../repositories/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository tvRepository;

  GetTvRecommendations(this.tvRepository);

  Future<Either<Failure, List<TV>>> execute(id) {
    return tvRepository.getTvRecommendations(id);
  }
}