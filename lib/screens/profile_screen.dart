import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../widgets/profile_item.dart';
import '../widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/ProfileScreen';

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
      await Future.delayed(const Duration(seconds: 2)); // simulate loading
      final data = {
        "name": "Shereen Elhossainy",
        "email": "shereen@example.com",
        "image": "https://i.pravatar.cc/300"
      };

      setState(() {
        userData = data;
      });

      // لو عايزة ترجعي للـ API الحقيقي بعدين:
      // final data = await userService.fetchUserData();
      // setState(() {
      //   userData = data;
      // });
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
                  ProfileHeader(
                    name: userData!['name'],
                    email: userData!['email'],
                    imageUrl: userData!['image'],
                  ),
                  const SizedBox(height: 20),
                  ProfileItem(icon: Icons.shopping_bag, title: "Orders"),
                  ProfileItem(icon: Icons.settings, title: "Settings"),
                  ProfileItem(
                      icon: Icons.logout, title: "Logout", color: Colors.red),
                ],
              ),
            ),
    );
  }
}
