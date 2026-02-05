import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Movie> movies = [
    Movie(
      title: 'Interstellar',
      posterPath:
      'https://image.tmdb.org/t/p/w500/8N0DNa1lN0kQnGJ1mP2pOe1xE9Z.jpg',
      rating: '8.6',
      overview:
      'A team of explorers travel through a wormhole in space in an attempt to ensure humanity’s survival.',
    ),
    Movie(
      title: 'Inception',
      posterPath:
      'https://image.tmdb.org/t/p/w500/edv5CZvWj09upOsy2Y6IwDhK8bt.jpg',
      rating: '8.8',
      overview:
      'A thief who steals corporate secrets through dream-sharing technology is given an inverse task.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: movies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            return MovieCard(movie: movies[index]);
          },
        ),
      ),
    );
  }
}
