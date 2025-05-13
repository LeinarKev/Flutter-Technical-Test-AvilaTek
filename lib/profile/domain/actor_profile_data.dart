class ActorProfileData {
  final int id;
  final String name;
  final String profilePath;
  final String biography;

  ActorProfileData({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.biography,
  });

  factory ActorProfileData.fromJson(Map<String, dynamic> json) {
    final String rawProfilePath = json['profile_path'] ?? '';
    final String fullProfilePath = rawProfilePath.isNotEmpty
        ? 'https://image.tmdb.org/t/p/w500$rawProfilePath'
        : '';

    return ActorProfileData(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Nombre no disponible',
      profilePath: fullProfilePath,
      biography: json['biography'] ?? 'Biografía no disponible',
    );
  }
}