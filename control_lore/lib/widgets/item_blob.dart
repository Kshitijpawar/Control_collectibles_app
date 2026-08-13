import 'package:control_lore/models/item.dart';
import 'package:control_lore/widgets/audio_blob.dart';
import 'package:control_lore/widgets/image_blob.dart';
import 'package:control_lore/widgets/video_blob.dart';
import 'package:flutter/material.dart';

class ItemBlob extends StatelessWidget {
  final BlobData blob;

  const ItemBlob({
    super.key,
    required this.blob,
  });

  @override
  Widget build(BuildContext context) {
    switch (blob.type.toLowerCase()) {
      case 'image':
        return ImageBlob(url: blob.link);
      case 'video':
        return VideoBlob(url: blob.link);
      case 'audio':
        return AudioBlob(url: blob.link);

      default:
        return const SizedBox.shrink();
    }
  }
}
