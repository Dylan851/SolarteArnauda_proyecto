import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Music {
  static final AudioPlayer audioPlayer = AudioPlayer();
  static bool _isPlaying = false;

  static Future<void> playMusic() async {
    try {
      // Don't restart if already playing
      if (_isPlaying) {
        return;
      }

      await audioPlayer.stop();
      await audioPlayer.release();

      if (kIsWeb) {
        // Web: use absolute path from web root
        await audioPlayer.setSource(UrlSource('assets/music/songRonnie.mp3'));
      } else {
        // Mobile / Desktop: NO leading slash for AssetSource
        await audioPlayer.setSource(AssetSource('assets/music/songRonnie.mp3'));
      }

      await audioPlayer.setReleaseMode(ReleaseMode.loop);
      await audioPlayer.setVolume(0.5);
      await audioPlayer.resume();

      _isPlaying = true;
      print("Música iniciada exitosamente");
    } catch (e) {
      print("Error al reproducir la música: $e");
      _isPlaying = false;
    }
  }

  static Future<void> stopMusic() async {
    try {
      await audioPlayer.stop();
      _isPlaying = false;
    } catch (e) {
      print("Error al detener la música: $e");
    }
  }
}
