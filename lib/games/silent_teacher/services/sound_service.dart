import 'package:just_audio/just_audio.dart';

class SoundService {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;
  SoundService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _soundEnabled = true;

  bool get soundEnabled => _soundEnabled;

  void toggleSound() {
    _soundEnabled = !_soundEnabled;
  }

  Future<void> _playAsset(String assetPath) async {
    if (!_soundEnabled) return;
    try {
      await _audioPlayer.setAsset(assetPath);
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing sound $assetPath: $e');
    }
  }

  Future<void> playSuccess() async {
    await _playAsset('assets/sounds/success.wav');
  }

  Future<void> playError() async {
    await _playAsset('assets/sounds/error.wav');
  }

  Future<void> playHint() async {
    await _playAsset('assets/sounds/hint.wav');
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

