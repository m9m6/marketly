import 'package:flutter/material.dart';

import '../model/items.dart';



class ProfileItemWidget extends StatelessWidget {
final ItemModel item;

  const ProfileItemWidget({
    Key? key, required this.item,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(item.icon, width: 28, height: 28),
              const SizedBox(width: 44),
              Text(item.title, style:TextStyle(fontSize: 16)),
              const Spacer(),
              Icon(Icons.arrow_forward_ios, size: 15),
              const SizedBox(width: 16),
            ],
          ),
          SizedBox(height: 30,)
        ],

      ),
    );
  }
}

// list view spreator // hyfsl been kol item w item
//sprator feh eldivider --> if index == 2
// el asa7 fel 4o8l el listview .

