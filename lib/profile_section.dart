import 'package:flutter/material.dart';
import 'package:marketly/profile_picture.dart';

import 'app_assets.dart';



class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        profilePicture(color: Colors.white, icon: AppAssets.cameraIcon,),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 40,),
            Text(
              'Mariam Badr',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'mariamalaabadr@gmailcom',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 13),
            GestureDetector(
              onTap: () {
                print(' edit profile works cilckable');
              },
              child: Container(
                width: 94,
                height: 23,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(5),

                ),
                child: Center(
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 16)
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    )
    ;
  }
}
