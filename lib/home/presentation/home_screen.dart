import 'package:flutter/material.dart';
import 'package:myapp/detail/presentation/detail_screen.dart';
import 'package:myapp/home/domain/movie.dart';
import 'package:myapp/home/infraestructure/movie_service.dart';
import 'package:myapp/home/presentation/movie_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              icon: const Icon(Icons.menu, color: Colors.white, size: 25),
              onPressed: () {},
            ),
          ),
        ),
        title: const Text(
          'Latest',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Movie>>(
        future: MovieService().getPopularMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final movies = snapshot.data ?? [];

          List<Movie> leftMovies = [];
          List<Movie> rightMovies = [];
          for (int i = 0; i < movies.length; i++) {
            if (i % 2 == 0) {
              leftMovies.add(movies[i]);
            } else {
              rightMovies.add(movies[i]);
            }
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: leftMovies
                        .map(
                          (movie) => InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(
                                    milliseconds: 700,
                                  ),
                                  pageBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) => DetailScreen(movie: movie),
                                  transitionsBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                        child,
                                      ) {
                                        final curvedAnimation = CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeInOut,
                                        );
                                        return FadeTransition(
                                          opacity: curvedAnimation,
                                          child: ScaleTransition(
                                            scale: Tween<double>(
                                              begin: 0.0,
                                              end: 1.0,
                                            ).animate(curvedAnimation),
                                            alignment: Alignment.center,
                                            child: child,
                                          ),
                                        );
                                      },
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
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
                            (movie) => InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: const Duration(
                                      milliseconds: 700,
                                    ),
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => DetailScreen(movie: movie),
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
                                                curve: Curves.easeInOut,
                                              );
                                          return FadeTransition(
                                            opacity: curvedAnimation,
                                            child: ScaleTransition(
                                              scale: Tween<double>(
                                                begin: 0.0,
                                                end: 1.0,
                                              ).animate(curvedAnimation),
                                              alignment: Alignment.center,
                                              child: child,
                                            ),
                                          );
                                        },
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
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
    );
  }
}
