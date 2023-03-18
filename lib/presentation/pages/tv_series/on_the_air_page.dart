import 'package:ditonton/presentation/bloc/tv/on_the_air/tv_on_air_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/tv_card_list.dart';

class OnTheAirPage extends StatefulWidget {
  const OnTheAirPage({super.key});

  static const ROUTE_NAME = '/on-the-air';

  @override
  State<OnTheAirPage> createState() => _OnTheAirPageState();
}

class _OnTheAirPageState extends State<OnTheAirPage> {
   @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvOnAirBloc>().add(LoadOnAirTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            BlocBuilder<TvOnAirBloc, TvOnAirState>(
              builder: (context, state) {
              if (state is TvOnAirLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvOnAirHasData) {
                final result = state.result;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tvData = result[index];
                    return TvCard(tvData);
                  },
                  itemCount: result.length,
                );
              } else if (state is TvOnAirError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Expanded(
                  child: Container(),
                );
              }
        }),
      ),
    );
  }
}
