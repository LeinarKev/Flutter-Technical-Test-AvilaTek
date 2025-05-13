import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/home/domain/movie.dart';
import 'package:myapp/home/domain/movie_data.dart';

class ActorMovieCreditsService {
  Future<List<Movie>> getMovieCredits(int personId) async {
    final endpoint = 'https://api.themoviedb.org/3/person/$personId/movie_credits?language=en-US';
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
      final List<dynamic> results = jsonData['cast'] ?? [];
      return results.map((jsonItem) {
        final movieData = MovieData.fromJson(jsonItem as Map<String, dynamic>);
        return Movie(
          id: jsonItem['id'] ?? 0,
          title: movieData.title,
          posterPath: movieData.posterPath,
          voteAverage: movieData.voteAverage,
        );
      }).toList();
    } else {
      throw Exception('Error al obtener Peliculas por Actor: ${response.statusCode}');
    }
  }
}
