import 'package:ditonton/presentation/bloc/movies/movies_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/utils.dart';
import '../widgets/movie_card_list.dart';
import '../widgets/tv_card_list.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();

  static const ROUTE_NAME = '/watchlist';
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieWatchlistBloc>().add(LoadMovieWatchlist());
      context.read<WatchlistTvBloc>().add(LoadWatchlistTv());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Future.microtask(() {
      context.read<MovieWatchlistBloc>().add(LoadMovieWatchlist());
      context.read<WatchlistTvBloc>().add(LoadWatchlistTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: const TabBar(tabs: [
            Tab(text: 'Movies'),
            Tab(text: 'Tv Series'),
          ]),
        ),
        body: TabBarView(children: [
          MovieWatchlist(),
          TvWatchlist(),
        ]),
      ),
    ));
  }
}

class MovieWatchlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
        builder: (context, state) {
          if (state is MovieWatchlistLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieWatchlistHasData) {
            
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movie[index];
                  return MovieCard(movie);
                },
                itemCount: state.movie.length,
              );
            
          } else if (state is MovieWatchlistEmpty) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text('Gagal memuat data'),
            );
          }
        },
      ),
    );
  }
}

class TvWatchlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvBloc, WatchlististTvState>(
        builder: (context, state) {
          if (state is WatchlistTvLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final data = state.tv[index];
                  return TvCard(data);
                },
                itemCount: state.tv.length,
              ); 
          } else if (state is WatchlistTvError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is WatchlistTvEmpty) {
            return Center(
              child: Text(state.message),
            );
          }
          else {
            return Center(
              key: Key('error_message'),
              child: Text('Failed'),
            );
          }
        },
      ),
    );
  }
}
