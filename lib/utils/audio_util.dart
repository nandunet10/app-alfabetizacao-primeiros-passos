// lib/services/audio_util.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class AudioUtil {
  static final AudioPlayer player = AudioPlayer();

  /// Toca um arquivo de áudio baseado no path do JSON
  /// Ex: "letras/A.mp3" ou "monossilabas/PE.mp3"
  static Future<void> tocarAudio(String audioDoJson) async {
    final path = 'audios/$audioDoJson'; // concatena a pasta de assets

    debugPrint('Tentando tocar: $path');

    try {
      await player.play(AssetSource(path));
      debugPrint('Tocando: $path');
    } catch (e) {
      debugPrint('Erro ao tocar $path: $e');
    }
  }
}
