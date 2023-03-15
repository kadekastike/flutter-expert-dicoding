import 'package:ditonton/presentation/provider/tv_series/on_the_air_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/state_enum.dart';
import '../../widgets/tv_card_list.dart';

class OnTheAirPage extends StatefulWidget {
  const OnTheAirPage({super.key});

  @override
  State<OnTheAirPage> createState() => _OnTheAirPageState();

  static const ROUTE_NAME = '/on-the-air';
}

class _OnTheAirPageState extends State<OnTheAirPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<OnTheAirNotifier>(context, listen: false)
        .fetchOnTheAirTv()
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: Text('On The Air TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnTheAirNotifier>(
          builder: (context, data, child) {
            if (data.onTheAirTvState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.onTheAirTvState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvData = data.onTheAir[index];
                  return TvCard(tvData);
                },
                itemCount: data.onTheAir.length,
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