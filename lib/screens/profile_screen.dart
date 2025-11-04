import 'package:flutter/material.dart';
import '../app_assets.dart';
import '../items_section.dart';
import '../model/items.dart';
import '../profile_section.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/ProfileScreen';
  ProfileScreen({Key? key});

  List<ItemModel> itemsList = [
    ItemModel(icon: AppAssets.favIcon, title: 'Favourites'),
    ItemModel(icon: AppAssets.downloadsIcon, title: 'Downloads'),
    ItemModel(icon: AppAssets.languagesIcon, title: 'Languages'),
    ItemModel(icon: AppAssets.locationIcon, title: 'Location'),
    ItemModel(icon: AppAssets.subscriptionIcon, title: 'Subscription'),
    ItemModel(icon: AppAssets.displayIcon, title: 'Display'),
    ItemModel(icon: AppAssets.clearCacheIcon, title: 'Clear Cache'),
    ItemModel(icon: AppAssets.clearHistoryIcon, title: 'Clear History'),
    ItemModel(icon: AppAssets.logOutIcon, title: 'Log Out'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new,
              color: Color(0xFFFF6B00), size: 30),
        ),
        title: Center(
            child: Text('My Profile',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                )
            )
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Icon(Icons.settings,
                color: Color(0xFFFF6B00), size: 30),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            ProfileSection(),
            SizedBox(height: 38),
            Expanded(
              child: ListView.separated(
                itemCount: itemsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return index == 8
                      ? Column(
                    children: [
                      ProfileItemWidget(item: itemsList[index]),
                      Divider(color: Colors.grey[300], thickness: 1),
                    ],
                  )
                      : ProfileItemWidget(item: itemsList[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  if (index == 1 || index == 5) {
                    return Divider(color: Colors.grey[300], thickness: 1);
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'ver @2.2 by mariam',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}