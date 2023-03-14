import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../../../common/failure.dart';

class SaveWatchlistTV {
  final TvRepository tvRepository;

  SaveWatchlistTV(this.tvRepository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail) {
    return tvRepository.saveTvWatchlist(tvDetail);
  }
}