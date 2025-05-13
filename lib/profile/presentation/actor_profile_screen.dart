import 'package:flutter/material.dart';
import 'package:myapp/detail/presentation/detail_screen.dart';
import 'package:myapp/home/domain/movie.dart';
import 'package:myapp/home/presentation/home_screen.dart';
import 'package:myapp/home/presentation/movie_card_widget.dart';
import 'package:myapp/profile/domain/actor_profile.dart';
import 'package:myapp/profile/infraestructure/actor_profile_cast_service.dart';
import 'package:myapp/profile/infraestructure/actor_profile_service.dart';

class ActorProfileScreen extends StatelessWidget {
  final int actorId;

  const ActorProfileScreen({super.key, required this.actorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF36ECA1),
                  Color.fromARGB(255, 0, 200, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 700),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HomeScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          final curvedAnimation = CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeInOut,
                          );
                          return FadeTransition(
                            opacity: curvedAnimation,
                            child: ScaleTransition(
                              scale: Tween<double>(
                                begin: 0.8,
                                end: 1.0,
                              ).animate(curvedAnimation),
                              child: child,
                            ),
                          );
                        },
                  ),
                  (route) => false,
                );
              },
            ),
          ),
        ),
      ),
      body: FutureBuilder<ActorProfile>(
        future: ActorProfileService().getActorProfile(actorId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final actorProfile = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: actorProfile.profilePath.isNotEmpty
                          ? NetworkImage(actorProfile.profilePath)
                          : null,
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            actorProfile.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            actorProfile.biography,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Cast On',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 16),
                FutureBuilder<List<Movie>>(
                  future: ActorMovieCreditsService().getMovieCredits(
                    actorProfile.id,
                  ),
                  builder: (context, snapshotMovies) {
                    if (snapshotMovies.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshotMovies.hasError) {
                      return const Text(
                        'Error al cargar movie credits',
                        style: TextStyle(color: Colors.red),
                      );
                    }
                    final movies = snapshotMovies.data ?? [];
                    List<Movie> leftMovies = [];
                    List<Movie> rightMovies = [];
                    for (int i = 0; i < movies.length; i++) {
                      if (i % 2 == 0) {
                        leftMovies.add(movies[i]);
                      } else {
                        rightMovies.add(movies[i]);
                      }
                    }
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 700),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: Row(
                        key: const ValueKey('movies-list'),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: leftMovies
                                  .map(
                                    (movie) => Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 16,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              transitionDuration:
                                                  const Duration(
                                                    milliseconds: 700,
                                                  ),
                                              pageBuilder:
                                                  (
                                                    context,
                                                    animation,
                                                    secondaryAnimation,
                                                  ) => DetailScreen(
                                                    movie: movie,
                                                  ),
                                              transitionsBuilder:
                                                  (
                                                    context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child,
                                                  ) {
                                                    final curvedAnimation =
                                                        CurvedAnimation(
                                                          parent: animation,
                                                          curve:
                                                              Curves.easeInOut,
                                                        );
                                                    return FadeTransition(
                                                      opacity: curvedAnimation,
                                                      child: ScaleTransition(
                                                        scale:
                                                            Tween<double>(
                                                              begin: 0.8,
                                                              end: 1.0,
                                                            ).animate(
                                                              curvedAnimation,
                                                            ),
                                                        child: child,
                                                      ),
                                                    );
                                                  },
                                            ),
                                          );
                                        },
                                        child: MovieCard(movie: movie),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Column(
                                children: rightMovies
                                    .map(
                                      (movie) => Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 16,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                transitionDuration:
                                                    const Duration(
                                                      milliseconds: 700,
                                                    ),
                                                pageBuilder:
                                                    (
                                                      context,
                                                      animation,
                                                      secondaryAnimation,
                                                    ) => DetailScreen(
                                                      movie: movie,
                                                    ),
                                                transitionsBuilder:
                                                    (
                                                      context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child,
                                                    ) {
                                                      final curvedAnimation =
                                                          CurvedAnimation(
                                                            parent: animation,
                                                            curve: Curves
                                                                .easeInOut,
                                                          );
                                                      return FadeTransition(
                                                        opacity:
                                                            curvedAnimation,
                                                        child: ScaleTransition(
                                                          scale:
                                                              Tween<double>(
                                                                begin: 0.8,
                                                                end: 1.0,
                                                              ).animate(
                                                                curvedAnimation,
                                                              ),
                                                          child: child,
                                                        ),
                                                      );
                                                    },
                                              ),
                                            );
                                          },
                                          child: MovieCard(movie: movie),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
