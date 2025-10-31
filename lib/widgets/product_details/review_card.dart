import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String comment;
  final int stars;

  const ReviewCard(
      {super.key, required this.name, required this.comment, required this.stars});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/p1.jpeg'),
              ),
              const SizedBox(width: 10),
              Text(name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              const Spacer(),
              Row(
                children: List.generate(
                    stars,
                    (i) => const Icon(Icons.star,
                        size: 18, color: Colors.orange)),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(comment, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}
