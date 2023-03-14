import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';

import '../../common/failure.dart';
import '../entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<TV>>> getOnAirTv();
  Future<Either<Failure, List<TV>>> getPopularTv();
  Future<Either<Failure, List<TV>>> getTopRatedTv();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<TV>>> getTvRecommendations(int id);
  Future<Either<Failure, List<TV>>> searchTv(String query);
}