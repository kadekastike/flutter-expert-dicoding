import 'package:dartz/dartz.dart';
import '../../../common/failure.dart';
import '../../entities/tv.dart';
import '../../repositories/tv_repository.dart';

class GetPopularTv {
  final TvRepository tvRepository;

  GetPopularTv(this.tvRepository);

  Future<Either<Failure, List<TV>>> execute() {
    return tvRepository.getPopularTv();
  }
}