import 'package:flutter/material.dart';
import 'package:my_flutter_app/widgets/movie_section.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';
import '../providers/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> popularMovies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    final movies = await MovieService.getPopularMovies(1);
    setState(() {
      popularMovies = movies;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('JackMovs'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        children: [
          _buildBanner(popularMovies.first),
          const SizedBox(height: 16),
          MovieSection(
            title: 'Popular JackMovs',
            movies: popularMovies,
          ),
        ],
      ),
    );
  }

  Widget _buildBanner(Movie movie) {
    return Stack(
      children: [
        Image.network(
          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
        ),

        IconButton(
          icon: const Icon(Icons.dark_mode),
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
        ),
        Container(
          height: 220,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // ignore: deprecated_member_use
                Colors.black.withOpacity(0.1),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Text(
            movie.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
