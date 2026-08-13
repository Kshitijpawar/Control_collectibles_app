import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoBlob extends StatefulWidget {
  final String url;

  const VideoBlob({
    super.key,
    required this.url,
  });
  @override
  State<VideoBlob> createState() => _VideoBlobState();
}

class _VideoBlobState extends State<VideoBlob> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    final videoId =
        YoutubePlayerController.convertUrlToId(widget.url);

    if (videoId != null) {
      _controller = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: false,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Text(
        'Unable to load video',
        style: TextStyle(color: Colors.white),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: YoutubePlayer(
        controller: _controller!,
      ),
    );
  }
}
