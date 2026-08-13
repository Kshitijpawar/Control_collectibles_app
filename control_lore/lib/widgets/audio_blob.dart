import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioBlob extends StatefulWidget {
  final String url;
  const AudioBlob({
    super.key,
    required this.url,
  });

  @override
  State<AudioBlob> createState() => _AudioBlobState();
}

class _AudioBlobState extends State<AudioBlob> {
  final AudioPlayer _player = AudioPlayer();
  @override
  void initState() {
    _player.setUrl(widget.url);
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, snapshot) {
        final playing = snapshot.data?.playing ?? false;

        return IconButton(
          iconSize: 50,
          color: Colors.white,
          onPressed: () {
            if (playing) {
              _player.pause();
            } else {
              _player.play();
            }
          },
          icon: Icon(playing ? Icons.pause_circle : Icons.play_circle),
        );
      },
    );
  }
}
