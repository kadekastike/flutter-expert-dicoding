import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
  backdropPath: '/v8Y9yurHuI7MujWQMd8iL3Gy4B5.jpg',
  firstAirDate: '2010-06-08',
  genreIds: [80, 18],
  id: 62560,
  name: 'Mr. Robot',
  originalName: 'Mr. Robot',
  overview:
      "While running from a drug deal gone bad, Mike Ross, a brilliant young college-dropout, slips into a job interview with one of New York City's best legal closers, Harvey Specter. Tired of cookie-cutter law school grads, Harvey takes a gamble by hiring Mike on the spot after he recognizes his raw talent and photographic memory. Mike and Harvey are a winning team. Even though Mike is a genius, he still has a lot to learn about law. And while Harvey may seem like an emotionless, cold-blooded shark, Mike's sympathy and concern for their cases and clients will help remind Harvey why he went into law in the first place. Mike's other allies in the office include the firm's best paralegal Rachel and Harvey's no-nonsense assistant Donna to help him serve justice. Proving to be an irrepressible duo and invaluable to the practice, Mike and Harvey must keep their secret from everyone including managing partner Jessica and Harvey's arch nemesis Louis, who seems intent on making Mike's life as difficult as possible.",
  popularity: 37.882356,
  posterPath: '/esN3gWb1P091xExLddD2nh4zmi3.jpg',
  voteAverage: 7.5,
  voteCount: 287,
);
  final tTv = TV(
  backdropPath: '/v8Y9yurHuI7MujWQMd8iL3Gy4B5.jpg',
  firstAirDate: '2010-06-08',
  genreIds: [80, 18],
  id: 62560,
  name: 'Mr. Robot',
  originalName: 'Mr. Robot',
  overview:
      "While running from a drug deal gone bad, Mike Ross, a brilliant young college-dropout, slips into a job interview with one of New York City's best legal closers, Harvey Specter. Tired of cookie-cutter law school grads, Harvey takes a gamble by hiring Mike on the spot after he recognizes his raw talent and photographic memory. Mike and Harvey are a winning team. Even though Mike is a genius, he still has a lot to learn about law. And while Harvey may seem like an emotionless, cold-blooded shark, Mike's sympathy and concern for their cases and clients will help remind Harvey why he went into law in the first place. Mike's other allies in the office include the firm's best paralegal Rachel and Harvey's no-nonsense assistant Donna to help him serve justice. Proving to be an irrepressible duo and invaluable to the practice, Mike and Harvey must keep their secret from everyone including managing partner Jessica and Harvey's arch nemesis Louis, who seems intent on making Mike's life as difficult as possible.",
  popularity: 37.882356,
  posterPath: '/esN3gWb1P091xExLddD2nh4zmi3.jpg',
  voteAverage: 7.5,
  voteCount: 287,
);
  test('should be a subclass of Movie entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}