import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageBlob extends StatelessWidget {
  final String url;

  const ImageBlob({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
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
    );
  }
}
