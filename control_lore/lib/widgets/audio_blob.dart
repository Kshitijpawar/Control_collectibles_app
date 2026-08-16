import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

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
  final soloud = SoLoud.instance;
  AudioSource? currentSound;
  SoundHandle? handle;

  bool isLoading = true;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    await soloud.init();
    final sound = await soloud.loadUrl(widget.url);

    if (!mounted) {
      await soloud.disposeSource(sound);
      return;
    }

    setState(() {
      currentSound = sound;
      isLoading = false;
    });
  }

  void _togglePlayPause() {
    final sound = currentSound;
    if (sound == null) return;
    if (handle == null) {
      handle = soloud.play(
        sound,
        volume: 1.0,
        pan: 0.0,
        paused: false,
        looping: false,
      );
      setState(() {
        isPlaying = true;
      });
      return;
    }

    soloud.pauseSwitch(handle!);
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    final sound = currentSound;

    if (sound != null) {
      soloud.disposeSource(sound);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 50,
      color: Colors.white,
      onPressed: isLoading ? null : _togglePlayPause,
      icon: isLoading
          ? const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            )
          : Icon(
              isPlaying ? Icons.pause_circle : Icons.play_circle,
            ),
    );
  }
}
