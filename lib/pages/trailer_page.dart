import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../services/movie_service.dart';

class TrailerPage extends StatefulWidget {
  final int movieId;

  const TrailerPage({super.key, required this.movieId});

  @override
  State<TrailerPage> createState() => _TrailerPageState();
}

class _TrailerPageState extends State<TrailerPage> {
  YoutubePlayerController? controller;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    loadTrailer();
  }

  Future<void> loadTrailer() async {
    try {
      final trailerKey =
      await MovieService.getTrailerKey(widget.movieId);

      if (trailerKey == null) {
        setState(() => isError = true);
        return;
      }

      controller = YoutubePlayerController.fromVideoId(
        videoId: trailerKey, // 🔥 INI YANG KURANG
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          mute: false,
        ),
      );

      setState(() {});
    } catch (e) {
      setState(() => isError = true);
    }
  }

  @override
  void dispose() {
    controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trailer')),
      body: isError
          ? const Center(
        child: Text(
          'Trailer tidak tersedia',
          style: TextStyle(fontSize: 16),
        ),
      )
          : controller == null
          ? const Center(child: CircularProgressIndicator())
          : YoutubePlayer(
        controller: controller!,
        aspectRatio: 16 / 9,
      ),
    );
  }
}
