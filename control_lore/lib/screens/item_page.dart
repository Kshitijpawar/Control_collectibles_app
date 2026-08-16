import 'package:cached_network_image/cached_network_image.dart';
import 'package:control_lore/screens/app_bar.dart';
import 'package:control_lore/screens/background_page.dart';
import 'package:control_lore/widgets/item_blob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/item.dart';

class ItemPage extends StatelessWidget {
  final Item item;
  const ItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: BackgroundWidget(
        theChildWidget: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                item.itemName,
                style: const TextStyle(
                  fontFamily: 'ITCAvantGardeStd-Demi',
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 231, 0, 13),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (item.blob != null) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ItemBlob(blob: item.blob!),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
              if (item.payload.text.isEmpty)
                Text(
                  item.payload.type.replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'ITCAvantGardeStd-Demi',
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 231, 0, 13),
                  ),
                ),
              Html(
                data: item.payload.text,
                style: {
                  "p": Style(
                    color: Colors.white,
                    fontFamily: 'AGBuchBQ-Regular',
                  )
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}