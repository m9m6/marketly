import 'package:finalapp/services/user_service.dart';
import 'package:finalapp/widgets_screen/profile_item.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userService = UserService();
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    try {
      final data = await userService.fetchUserData();
      setState(() {
        userData = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(userData!['image']),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    userData!['name'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(userData!['email']),
                  const SizedBox(height: 20),
                  ProfileItem(icon: Icons.shopping_bag, title: "Orders"),
                  ProfileItem(icon: Icons.settings, title: "Settings"),
                  ProfileItem(icon: Icons.logout, title: "Logout", color: Colors.red),
                ],
              ),
            ),
    );
  }
}
