import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkTheme = false;
  bool promotions = true;
  bool orderUpdates = true;
  bool newArrivals = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          buildSectionTitle("General"),
          _buildSettingTile(
            icon: Icons.dark_mode_outlined,
            title: "Theme",
            trailing: Switch.adaptive(
              activeColor: Colors.orange,
              value: isDarkTheme,
              onChanged: (val) => setState(() => isDarkTheme = val),
            ),
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.language,
            title: "Language",
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "English",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 6),
                Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
              ],
            ),
          ),

          const SizedBox(height: 25),

          buildSectionTitle("Notifications"),
          _buildSettingTile(
            icon: Icons.local_offer_outlined,
            title: "Promotions",
            trailing: Switch.adaptive(
              activeColor: Colors.orange,
              value: promotions,
              onChanged: (val) => setState(() => promotions = val),
            ),
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.shopping_bag_outlined,
            title: "Order Updates",
            trailing: Switch.adaptive(
              activeColor: Colors.orange,
              value: orderUpdates,
              onChanged: (val) => setState(() => orderUpdates = val),
            ),
          ),
          const Divider(height: 1),
          _buildSettingTile(
            icon: Icons.new_releases_outlined,
            title: "New Arrivals",
            trailing: Switch.adaptive(
              activeColor: Colors.orange,
              value: newArrivals,
              onChanged: (val) => setState(() => newArrivals = val),
            ),
          ),

          const SizedBox(height: 25),

          buildSectionTitle("Support & Privacy"),
          _buildArrowTile("Privacy Policy", Icons.privacy_tip_outlined),
          const Divider(height: 1),
          _buildArrowTile("Terms of Service", Icons.description_outlined),
          const Divider(height: 1),
          _buildArrowTile("Contact Us", Icons.phone_in_talk_outlined),
          const Divider(height: 1),
          _buildArrowTile("About", Icons.info_outline),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 15),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required Widget trailing,
  }) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildArrowTile(String title, IconData icon) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        ],
      ),
    );
  }
}
