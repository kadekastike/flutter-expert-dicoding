import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import '../../entities/tv.dart';

class SearchTv {
  final TvRepository tvRepository;

  SearchTv(this.tvRepository);

  Future<Either<Failure, List<TV>>> execute(String query) {
    return tvRepository.searchTv(query);
  }
}