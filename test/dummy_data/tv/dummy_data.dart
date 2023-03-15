import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testTv = TV(
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

final testTvList = [testTv];

final testTvDetail = TvDetail(
    backdropPath: "backdropPath",
    episodeRunTime: [1, 2, 3, 4],
    firstAirDate: "2013-2-2",
    genres: [Genre(id: 1, name: "tv")],
    homepage: "homepage",
    id: 1,
    languages: ["en"],
    lastAirDate: "2020-10-10",
    name: "name",
    numberOfEpisodes: 2,
    numberOfSeasons: 10,
    originCountry: ["en"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 33.3933,
    posterPath: "posterPath",
    voteAverage: 12,
    voteCount: 10);

final testWatchlistTv = TV.watchlist(
    id: 1, overview: "overview", posterPath: "posterPath", name: "name");

final testTvTable = TvTable(
    id: 1, name: "name", posterPath: "posterPath", overview: "overview");

final testTvMap = {
  'id': 1,
  'name': 'name',
  'posterPath': 'posterPath',
  'overview': 'overview'
};