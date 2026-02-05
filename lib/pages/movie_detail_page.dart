import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/favorite_service.dart';
import 'trailer_page.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.overview),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      FutureBuilder<bool>(
                        future: FavoriteService.isFavorite(movie.id.toString()),
                        builder: (context, snapshot) {
                          final isFav = snapshot.data ?? false;
                          return IconButton(
                            icon: Icon(
                              isFav
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              await FavoriteService.toggleFavorite(
                                  movie.id.toString());
                              setState(() {});
                            },
                          );
                        },
                      ),
                      const Text('Add to Favorite'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Play Trailer'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              TrailerPage(movieId: movie.id),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
