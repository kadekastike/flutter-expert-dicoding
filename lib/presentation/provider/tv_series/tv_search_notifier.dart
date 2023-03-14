import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_series/search_tv.dart';
import 'package:flutter/material.dart';

class SearchTvNotifier extends ChangeNotifier {
  final SearchTv searchTv;

  SearchTvNotifier({ required this.searchTv});

  List<TV> _searchResult = []; 
  List<TV> get searchResult => _searchResult;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchSearchResult(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTv.execute(query);
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (searchResultData) {
        _state = RequestState.Loaded;
        _searchResult = searchResultData;
        notifyListeners();
      });
  }
}