import 'package:ditonton/presentation/provider/tv_series/top_rated_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/state_enum.dart';
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
    Future.microtask(() => 
      Provider.of<TopRatedTvNotifier>(context, listen: false)
        .fetchTopRatedTv());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTvNotifier>(
          builder: (builder, data, child) {
            if (data.topRatedTvState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.topRatedTvState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final topRated = data.topRatedTv[index];
                  return TvCard(topRated);
                },
                itemCount: data.topRatedTv.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          }),
        ),
    );
  }
}