import 'package:flutter/material.dart';
import 'package:myapp/detail/domain/actor.dart';
import 'package:myapp/detail/infraestructure/actor_service.dart';
import 'package:myapp/detail/presentation/actor_card_widget.dart';
import 'package:myapp/home/domain/movie.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _showDetails = false;
  late final Future<List<Actor>> _actorsFuture;

  @override
  void initState() {
    super.initState();
    _actorsFuture = ActorService().getActors(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showDetails = !_showDetails;
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                widget.movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF36ECA1), Color(0xFF29C6F2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _showDetails ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  color: const Color.fromARGB(181, 0, 0, 0),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movie.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(widget.movie.voteAverage * 10).toStringAsFixed(1)}% User Score',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      FutureBuilder<List<Actor>>(
                        future: _actorsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return const Text(
                              'Error al cargar actores',
                              style: TextStyle(color: Colors.white),
                            );
                          }
                          final actors = snapshot.data ?? [];
                          return AnimatedOpacity(
                            opacity: _showDetails ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: actors
                                  .map((actor) => ActorCard(actor: actor))
                                  .toList(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
