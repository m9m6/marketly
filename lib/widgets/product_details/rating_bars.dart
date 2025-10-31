import 'package:flutter/material.dart';

class RatingBars extends StatelessWidget {
  final double rating;
  const RatingBars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            children: List.generate(5, (index) {
              int starLevel = 5 - index;
              double percentage = (rating >= starLevel)
                  ? 1.0
                  : (rating > starLevel - 1 ? rating - (starLevel - 1) : 0.0);

              return Row(
                children: [
                  Text("$starLevel★"),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Container(
                      height: 7,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: percentage.clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}
