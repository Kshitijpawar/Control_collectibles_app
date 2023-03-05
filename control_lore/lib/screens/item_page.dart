// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';

import '../models/item.dart';

class ItemPage extends StatelessWidget {
  final Item item;
  const ItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text("item page"),
              Text("item name : ${item.itemName}"),
              Text("item name : ${item.itemUrl}"),
              // Text("item name : ${item.itemName}"),

            ],
          ),
        ),
      ),
    );
  }
}
