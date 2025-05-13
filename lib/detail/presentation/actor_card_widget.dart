import 'package:flutter/material.dart';
import 'package:myapp/detail/domain/actor.dart';
import 'package:myapp/profile/presentation/actor_profile_screen.dart';

class ActorCard extends StatelessWidget {
  final Actor actor;

  const ActorCard({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 700),
            pageBuilder: (context, animation, secondaryAnimation) =>
                ActorProfileScreen(actorId: actor.id),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: child,
                ),
              );
            },
          ),
        );
      },
      child: Container(
        width: 100, 
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: actor.profilePath.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(actor.profilePath),
                  fit: BoxFit.cover,
                )
              : null,
          color: Colors.grey[300],
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(181, 0, 0, 0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  actor.name,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  actor.character,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}