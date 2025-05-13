import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/detail/domain/actor.dart';
import 'package:myapp/detail/domain/actor_data.dart';

class ActorService {
  Future<List<Actor>> getActors(int movieId) async {

    final endpoint = 'https://api.themoviedb.org/3/movie/$movieId/credits';

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

      final List<dynamic> castList = jsonData['cast'] ?? [];

      final List<dynamic> limitedCast =
          castList.length > 3 ? castList.take(3).toList() : castList;
      return limitedCast.map<Actor>((jsonItem) {
        final actorData = ActorData.fromJson(jsonItem as Map<String, dynamic>);
        return Actor(
          id: actorData.id,
          name: actorData.name,
          profilePath: actorData.profilePath,
          character: actorData.character,
        );
      }).toList();
    } else {
      throw Exception('Error al obtener actores: ${response.statusCode}');
    }
  }
}