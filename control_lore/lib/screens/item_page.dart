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
      appBar: const CustomAppBar(),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: BackgroundWidget(
        theChildWidget: Center(
          child: SingleChildScrollView(
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
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: CachedNetworkImage(
                    imageUrl: item.itemImageUrl,
                    errorWidget: (context, url, error) {
                      return const Image(
                        image: ExactAssetImage('assets/Hiss_Pattern.png'),
                      );
                    },
                    progressIndicatorBuilder: (context, url, progress) {
                      return Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (item.itemText != "n/a")
                  const Text(
                    "TRANSCRIPT",
                    style: TextStyle(
                      fontFamily: 'ITCAvantGardeStd-Demi',
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 231, 0, 13),
                    ),
                  ),
                Html(
                  data: item.itemText,
                  style: {
                    "p": Style(
                        color: Colors.white, fontFamily: 'AGBuchBQ-Regular')
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class ImageDialog extends StatelessWidget {
//   final Item item;
//   const ImageDialog({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       // child: Container(
//       //   width: 200,
//       //   height: 200,
//       //   decoration: BoxDecoration(
//       //     image: DecorationImage(
//       //       image: CachedNetworkImageProvider(item.itemImageUrl),
//       //     ),
//       //   ),
//       // ),
//       child: Expanded(
//         child: CachedNetworkImage(
//           imageUrl: item.itemImageUrl,
//         ),
//       ),
//     );
//   }
// }
