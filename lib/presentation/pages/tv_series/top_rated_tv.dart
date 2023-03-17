import 'package:ditonton/presentation/bloc/tv/top%20rated%20tv/top_rated_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/tv_card_list.dart';

class TopRatedTvPage extends StatefulWidget {
  const TopRatedTvPage({Key? key}) : super(key: key);

  static const ROUTE_NAME = '/top-rated-tv';

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TopRatedTvBloc>().add(LoadTopRatedTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
          builder: (builder, state) {
            if (state is TopRatedTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final topRated = state.topRatedTvData[index];
                  return TvCard(topRated);
                },
                itemCount: state.topRatedTvData.length,
              );
            } else if (state is TopRatedTvError) {
              return Center(
                child: Text(state.message),
              );
            }
            else {
              return Center(
                key: Key('error_message'),
                child: Text('Data gagal dimuat'),
              );
            }
          }),
        ),
    );
  }
}