import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/home/domain/movie.dart';
import 'package:myapp/home/domain/movie_data.dart';

class MovieService {
  Future<List<Movie>> getPopularMovies() async {

    const endpoint =
        'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc';

    const String token =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYWQ1MjMxYTIzNjY4Y2ZjYzRjNWNhMjZiNDY1MDNjNyIsIm5iZiI6MTc0NzA3MDM1MS44NjUsInN1YiI6IjY4MjIyZDhmMGUwMGNmMjZmNDZlZTVkNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UmZO8V7CCm7JCWc5pkKhCDfA8OyeBizJLi4FC03p0lQ';

    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {

      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> results = jsonData['results'];
      return results.map((jsonItem) {
        final movieData = MovieData.fromJson(jsonItem as Map<String, dynamic>);
        return Movie(
          id: movieData.id,
          title: movieData.title,
          posterPath: movieData.posterPath,
          voteAverage: movieData.voteAverage,
        );
      }).toList();
    } else {
      throw Exception(
          'Error al obtener películas populares: ${response.statusCode}');
    }
  }
}