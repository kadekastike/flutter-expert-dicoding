import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_series/search_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/event_transformer.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTv _searchTv;

  SearchTvBloc(this._searchTv) : super(SearchTvInitial()) {
    on<OnQueryChanged>((event, emit) async {
      if (event.query.isEmpty) {
        emit(SearchTvInitial());
      } else {
        final query = event.query;
        emit(SearchTvLoading());
        final result = await _searchTv.execute(query);
        result.fold(
          (failure) => {
            emit(SearchTvError(failure.message))
          }, 
          (data) {
            if (data.isEmpty) {
              emit(SearchTvEmpty("Hasil pencarian tidah ditemukan"));
            } else {
              emit(SearchTvHasData(data));
            }
          });
      }
  
    },
    transformer: debounce(const Duration(milliseconds: 500))
  );
  }

}