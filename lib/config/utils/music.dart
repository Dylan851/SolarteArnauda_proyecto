import 'package:audioplayers/audioplayers.dart';

class Music {
  static final AudioPlayer audioPlayer = AudioPlayer();

  static Future<void> playMusic() async {
    try {
      // Detectar si es web
      bool isWeb = identical(0, 0.0);

      if (isWeb) {
        // Web: usar URL directamente
        await audioPlayer.play(UrlSource('assets\music\songRonnie.mp3'));
        await audioPlayer.setReleaseMode(ReleaseMode.loop);
        await audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
        await audioPlayer.setVolume(0.5);
      } else {
        // Mobile / Desktop
        await audioPlayer.play(AssetSource('assets\music\songRonnie.mp3'));
        await audioPlayer.setReleaseMode(ReleaseMode.loop);
        await audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
        await audioPlayer.setVolume(0.5);
      }
    } catch (e) {
      print("Error al reproducir la música: $e");
    }
  }
}
