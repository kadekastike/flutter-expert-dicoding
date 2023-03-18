part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadNowPlayingMovie extends NowPlayingEvent{}
