import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';

import '../../repositories/tv_repository.dart';

class GetTopRatedTv {
  final TvRepository tvRepository;

  GetTopRatedTv(this.tvRepository);

  Future<Either<Failure, List<TV>>> execute() {
    return tvRepository.getTopRatedTv();
  }
}