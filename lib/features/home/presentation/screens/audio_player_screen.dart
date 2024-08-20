import 'package:audioplayers/audioplayers.dart';
import 'package:chillzone/features/home/presentation/providers/providers.dart';
import 'package:chillzone/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPlayerScreen extends StatefulWidget {
  static const String routeName = '/audio_player_screen';

  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late final AudioPlayer _audioPlayer;
  late final Stream<PlayerState> _playerStateStream;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playerStateStream = _audioPlayer.onPlayerStateChanged;
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio(String audioUrl) async {
    await _audioPlayer.play(UrlSource(audioUrl));
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AudioProvider>().state;

    return state.map(
        loading: (_) => const CustomLoading(),
        success: (state) => Scaffold(
              body: Stack(
                children: [
                  const _Background(),
                  const _LeadingButton(),
                  Center(
                    child: StreamBuilder<PlayerState>(
                      stream: _playerStateStream,
                      builder: (context, snapshot) {
                        final playerState = snapshot.data;
                        final isPlaying = playerState == PlayerState.playing;

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (isPlaying) {
                                  _pauseAudio();
                                } else {
                                  _playAudio(state.currentTrack!.filePath);
                                }
                                setState(() {
                                  this.isPlaying = !this.isPlaying;
                                });
                              },
                              child: Text(isPlaying ? 'Pausar' : 'Reproducir'),
                            ),
                            ElevatedButton(
                              onPressed: _stopAudio,
                              child: const Text('Detener'),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        error: (state) => CustomErrorWidget(
              error: state.error,
              onRetry: () {
                Navigator.pop(context);
              },
            ));
  }
}

class _LeadingButton extends StatelessWidget {
  const _LeadingButton();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Positioned(
      top: 32,
      left: 16,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          size: size.height * 0.03,
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF144771),
            Color(0xFF071A2C),
          ],
        ),
      ),
    );
  }
}
