import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/profile/domain/actor_profile.dart';
import 'package:myapp/profile/domain/actor_profile_data.dart';

class ActorProfileService {
  Future<ActorProfile> getActorProfile(int actorId) async {
    final endpoint =
        'https://api.themoviedb.org/3/person/$actorId?language=en-US';

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
      final actorProfileData = ActorProfileData.fromJson(jsonData);
      return ActorProfile(
        id: actorProfileData.id,
        name: actorProfileData.name,
        profilePath: actorProfileData.profilePath,
        biography: actorProfileData.biography,
      );
    } else {
      throw Exception(
          'Error al obtener el perfil del actor: ${response.statusCode}');
    }
  }
}
