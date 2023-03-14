import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvWatchlistStatus {
  final TvRepository tvRepository;

  GetTvWatchlistStatus(this.tvRepository);

  Future<bool> execute(id) {
    return tvRepository.isAddedToWatchlist(id);
  }
}