import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(height: 15),
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 21, 21, 21),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          email,
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 73, 73, 73),
          ),
        ),
      ],
    );
  }
}
