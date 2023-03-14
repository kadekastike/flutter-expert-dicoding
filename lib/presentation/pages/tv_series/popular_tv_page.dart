import 'package:ditonton/presentation/provider/tv_series/popular_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/state_enum.dart';
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
    Future.microtask(() => 
      Provider.of<PopularTvNotifier>(context, listen: false)
        .fetchPopularTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTvNotifier>(
          builder: (context, data, child) {
            if (data.popularTvState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.popularTvState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvData = data.popularTv[index];
                  return TvCard(tvData);
                },
                itemCount: data.popularTv.length,
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