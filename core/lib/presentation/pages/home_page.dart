import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:about/about.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<NowPlayingMoviesBloc>().add(FetchNowPlayingMovies());
    context.read<PopularMoviesBloc>().add(FetchPopularMovies());
    context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies());
    context.read<OnTheAirTvsBloc>().add(FetchOnTheAirTvs());
    context.read<PopularTvsBloc>().add(FetchPopularTvs());
    context.read<TopRatedTvsBloc>().add(FetchTopRatedTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Movies'),
              accountEmail: Text('movies@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.live_tv),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pushNamed(context, HomeTvPage.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Movies'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist TV Series'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvsPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Movies'),
        actions: [
          DropdownButtonHideUnderline(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: DropdownButton(
                icon: Icon(Icons.search, color: Colors.white),
                items: [
                  DropdownMenuItem(
                    child: TextButton(
                      child: Text('Search Movies'),
                      onPressed: () {
                        Navigator.pushNamed(context, SearchMoviePage.routeName);
                      },
                    ),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: TextButton(
                      child: Text('Search Tv Series'),
                      onPressed: () {
                        Navigator.pushNamed(context, SearchTvPage.routeName);
                      },
                    ),
                    value: 2,
                  )
                ],
                onChanged: (int? value) {},
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Now Playing Movies',
                  style: kHeading6,
                ),
              ),
              BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                builder: (context, state) {
                  if (state is NowPlayingMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingMoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is NowPlayingMoviesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular Movies',
                onTap: () => Navigator.pushNamed(context, PopularMoviesPage.routeName),
              ),
              BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                builder: (context, state) {
                  if (state is PopularMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is PopularMoviesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated Movies',
                onTap: () => Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
              ),
              BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                builder: (context, state) {
                  if (state is TopRatedMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedMoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is TopRatedMoviesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              Divider(
                color: Colors.grey,
                height: 64.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'On The Air TV Series',
                  style: kHeading6,
                ),
              ),
              BlocBuilder<OnTheAirTvsBloc, OnTheAirTvsState>(
                builder: (context, state) {
                  if (state is OnTheAirTvsLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is OnTheAirTvsHasData) {
                    return TvList(state.result);
                  } else if (state is OnTheAirTvsError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular TV Series',
                onTap: () => Navigator.pushNamed(context, PopularTvsPage.routeName),
              ),
              BlocBuilder<PopularTvsBloc, PopularTvsState>(
                builder: (context, state) {
                  if (state is PopularTvsLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvsHasData) {
                    return TvList(state.result);
                  } else if (state is PopularTvsError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated TV Series',
                onTap: () => Navigator.pushNamed(context, TopRatedTvsPage.routeName),
              ),
              BlocBuilder<TopRatedTvsBloc, TopRatedTvsState>(
                builder: (context, state) {
                  if (state is TopRatedTvsLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvsHasData) {
                    return TvList(state.result);
                  } else if (state is TopRatedTvsError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            style: kHeading6,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
