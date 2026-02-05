class ApiService {
  static const String _apiKey = 'ee088ab7dec35fbe731dc1dbab655cd7';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  static String getPopularMoviesUrl(int page) {
    return '$_baseUrl/movie/popular?api_key=$_apiKey&page=$page';
  }

  static String searchMovieUrl(String query) {
    return '$_baseUrl/search/movie?api_key=$_apiKey&query=$query';
  }
}