class MovieData {
  final int id;
  final String title;
  final String posterPath;
  final double voteAverage;

  MovieData({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
  });

  factory MovieData.fromJson(Map<String, dynamic> json) {
    final String rawPosterPath = json['poster_path'] ?? '';
    final String fullPosterPath = rawPosterPath.isNotEmpty
        ? 'https://image.tmdb.org/t/p/w500$rawPosterPath'
        : '';

    return MovieData(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Título no disponible',
      posterPath: fullPosterPath,
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
    );
  }
}