import 'package:ditonton/presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/tv_card_list.dart';

class PopularTvPage extends StatefulWidget {
  const PopularTvPage({Key? key}) : super(key: key);

  static const ROUTE_NAME = '/popular-tv';

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PopularTvBloc>().add(LoadPopularTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvBloc, PopularTvState>(
          builder: (context, state) {
            if (state is PopularTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvData = state.popularTvData[index];
                  return TvCard(tvData);
                },
                itemCount: state.popularTvData.length,
              );
            } else if (state is PopularTvError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else { 
              return Center (
              child: Text('Failed'));
            }
          }),
      ),
    );
  }
}