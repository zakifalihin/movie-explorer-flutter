import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieService {
  static const String _apiKey = 'ee088ab7dec35fbe731dc1dbab655cd7';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  static Future<List<Movie>> getPopularMovies(int page) async {
    final url = Uri.parse(
        '$_baseUrl/movie/popular?api_key=$_apiKey&page=$page');

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    return (data['results'] as List)
        .map((e) => Movie.fromJson(e))
        .toList();
  }

  static Future<String?> getTrailerKey(int movieId) async {
    final url = Uri.parse(
      '$_baseUrl/movie/$movieId/videos?api_key=$_apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);
    final List results = data['results'];

    if (results.isEmpty) return null;

    // 🔥 FILTER TRAILER YOUTUBE
    final trailer = results.firstWhere(
          (video) =>
      video['site'] == 'YouTube' &&
          video['type'] == 'Trailer',
      orElse: () => null,
    );

    if (trailer == null) return null;

    return trailer['key'];
  }
}
