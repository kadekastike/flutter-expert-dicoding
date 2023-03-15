import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
      posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
      popularity: 47.432451,
      id: 31917,
      backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
      voteAverage: 5.04,
      overview:
          "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name  who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
      firstAirDate: "2010-06-08",
      genreIds: [18, 9648],
      voteCount: 133,
      name: "Pretty Little Liars",
      originalName: "Pretty Little Liars");
  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv/on_the_air.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "poster_path": "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
            "popularity": 47.432451,
            "id": 31917,
            "backdrop_path": "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
            "vote_average": 5.04,
            "overview":
                "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name  who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
            "first_air_date": "2010-06-08",
            "genre_ids": [18, 9648],
            "vote_count": 133,
            "name": "Pretty Little Liars",
            "original_name": "Pretty Little Liars"
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
