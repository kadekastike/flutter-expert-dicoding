import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../../entities/tv_detail.dart';
import '../../repositories/tv_repository.dart';

class GetDetailTv {
  final TvRepository tvRepository;

  GetDetailTv(this.tvRepository);

  Future<Either<Failure, TvDetail>> execute(id) {
    return tvRepository.getTvDetail(id);
  }
}