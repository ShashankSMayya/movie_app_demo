import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:movie_app/bloc/movie_cubit.dart';
import 'package:movie_app/data/core/api_client.dart';
import 'package:movie_app/data/core/api_constants.dart';
import 'package:movie_app/data/model/movie_response_model.dart';
import 'package:movie_app/data/repositories/movie_repository.dart';
import 'package:movie_app/ui/movie_detail.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie"),
      ),
      body: BlocProvider(
        create: (context) =>
            MovieCubit(MovieRepository(ApiClient(Client())))..loadMovies(),
        child: BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            if (state is MovieLoadSuccess) return MovieUI(movies: state.movies);
            if (state is MovieLoadFailed) return Text("failed");
            if (state is MovieLoading) return CircularProgressIndicator();
            return Container();
          },
        ),
      ),
    );
  }
}

class MovieUI extends StatelessWidget {
  final List<Results> movies;

  const MovieUI({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MovieDetail(movie: movies[index]),
          )),
          child: MovieCard(
            movie: movies[index],
          ),
        );
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final Results movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl: "${ApiConstants.baseImageUrl}${movie.posterPath}",
                  fadeInCurve: Curves.easeIn,
                  height: 200,
                  width: 125,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        movie.overview,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
