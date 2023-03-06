// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:control_lore/screens/app_bar.dart';
import 'package:control_lore/screens/background_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/item.dart';

class ItemPage extends StatelessWidget {
  final Item item;
  const ItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: BackgroundWidget(
          theChildWidget: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Text("item page"),
              SizedBox(
                height: 10,
              ),
              Text(
                item.itemName,
                style: TextStyle(
                  fontFamily: 'ITCAvantGardeStd-Demi',
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 231, 0, 13),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: CachedNetworkImage(
                    imageUrl: item.itemImageUrl,
                    errorWidget: (context, url, error) {
                      return Text("No Image Found");
                    },
                    progressIndicatorBuilder: (context, url, progress) {
                      return Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      );
                    },
                  )
                  // child: Image.network(
                  //   item.itemImageUrl,
                  //   errorBuilder: (context, error, stackTrace) {
                  //     return Text(
                  //       'error in widget!!!',
                  //       style: TextStyle(color: Colors.white),
                  //     );
                  //   },
                  //   loadingBuilder: (context, child, loadingProgress) {
                  //     if (loadingProgress == null) return child;
                  //     return Center(
                  //       child: CircularProgressIndicator(
                  //         value: loadingProgress.expectedTotalBytes != null
                  //             ? loadingProgress.cumulativeBytesLoaded /
                  //                 loadingProgress.expectedTotalBytes!
                  //             : null,
                  //       ),
                  //     );
                  //   },
                  // ),
                  ),
              SizedBox(
                height: 10,
              ),
              if (item.itemText != "n/a")
                Text(
                  "TRANSCRIPT",
                  style: TextStyle(
                    fontFamily: 'ITCAvantGardeStd-Demi',
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 231, 0, 13),
                  ),
                ),
              Html(data: item.itemText, style: {
                "p": Style(color: Colors.white, fontFamily: 'AGBuchBQ-Regular')
              }
                  // tagsList: Html.tags..remove(value),
                  )
              // Text("item name : ${item.itemUrl}"),
              // Text("item name : ${item.itemName}"),
            ],
          ),
        ),
      )),
    );
  }
}
