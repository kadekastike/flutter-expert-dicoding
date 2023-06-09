import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/tv/on_the_air/tv_on_air_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_series/top_rated_tv.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_search_page.dart';
import 'package:ditonton/presentation/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/constants.dart';
import 'on_the_air_page.dart';

class TvHomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv';

  @override
  State<TvHomePage> createState() => _TvHomePageState();
}

class _TvHomePageState extends State<TvHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvOnAirBloc>().add(LoadOnAirTv());
      context.read<PopularTvBloc>().add(LoadPopularTv());
      context.read<TopRatedTvBloc>().add(LoadTopRatedTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomNavigationDrawer(),
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildSubHeading(
              title: "On The Air",
              onTap: () =>
                  {Navigator.pushNamed(context, OnTheAirPage.ROUTE_NAME)}),
          BlocBuilder<TvOnAirBloc, TvOnAirState>(builder: (
            context,
            state,
          ) {
            if (state is TvOnAirLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvOnAirHasData) {
              final data = state.result;
              return TvList(data);
            } else if (state is TvOnAirError) {
              return Text(state.message);
            } else {
              return Text('Failed');
            }
          }),
          _buildSubHeading(
              title: "Popular",
              onTap: () =>
                  {Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME)}),
          BlocBuilder<PopularTvBloc, PopularTvState>(builder: (context, state) {
            if (state is PopularTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvHasData) {
              return TvList(state.popularTvData);
            } else if (state is PopularTvError) {
              return Text(state.message);
            } else {
              return Text('Failed');
            }
          }),
          _buildSubHeading(
              title: "Top Rated",
              onTap: () =>
                  {Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME)}),
          BlocBuilder<TopRatedTvBloc, TopRatedTvState>
          (builder: (context, state) {
            if (state is TopRatedTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvHasData) {
              return TvList(state.topRatedTvData);
            } else if (state is TopRatedTvError) {
              return Text(state.message);
            }
             else {
              return Text('Failed');
            }
          }),
        ])),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<TV> tv;

  TvList(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvData = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DetailTvPage.ROUTE_NAME,
                  arguments: tvData.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvData.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
