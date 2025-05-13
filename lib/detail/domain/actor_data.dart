class ActorData {
  final int id;
  final String name;
  final String profilePath;
  final String character;

  ActorData({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.character,
  });

  factory ActorData.fromJson(Map<String, dynamic> json) {
    final String rawPosterPath = json['profile_path'] ?? '';
    final String fullPosterPath = rawPosterPath.isNotEmpty
        ? 'https://image.tmdb.org/t/p/w500$rawPosterPath'
        : '';

    return ActorData(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Nombre no disponible',
      profilePath: fullPosterPath,
      character: json['character'] ?? 'Personaje no disponible',
    );
  }
}