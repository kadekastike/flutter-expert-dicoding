import 'package:ditonton/presentation/bloc/tv/search_tv/search_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/constants.dart';
import '../../widgets/tv_card_list.dart';

class SearchTvPage extends StatelessWidget {
  const SearchTvPage({Key? key}) : super(key: key);

  static const ROUTE_NAME = '/search-tv';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            TextField(
              onSubmitted: (query) {
                context.read<SearchTvBloc>().add(OnQueryChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTvBloc, SearchTvState>(
              builder: (context, state) {
                if (state is SearchTvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTvHasData) {
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tv = state.tv[index];
                        return TvCard(tv);
                      },
                      itemCount: state.tv.length,
                    ),
                  );
                } else if(state is SearchTvEmpty) {
                  return Center(child: Column (
                    children : [
                      SizedBox(height: 8.0,),
                      Text(state.message),
                    ]
                  ));
                } else if (state is SearchTvError) {
                  return Center(child: Column (
                    children : [
                      SizedBox(height: 8.0,),
                      Text(state.message),
                    ]
                  ));
                }
                else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },)
          ],
        ),
        ),
    );
  }
}