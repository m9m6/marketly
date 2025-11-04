import 'package:flutter/material.dart';

import 'app_assets.dart';


class profilePicture extends StatelessWidget {
  final Color color;
  final String icon;

  const profilePicture({super.key, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('change image');
      },
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(AppAssets.profileImage),
          ),
          Positioned(
            top: 74,
            right: 8,
            child: SizedBox(
              width: 25,
              height: 23,
              child: CircleAvatar(
                backgroundColor: color,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Image.asset(icon, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
