import 'package:chillzone/features/home/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AudioPlayerScreen extends StatelessWidget {
  static const String routeName = '/audio_player_screen';

  const AudioPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          _Background(),
          _LeadingButton(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AudioMetadata(),
                SizedBox(height: 16),
                Controls(),
                ProgressBar(),
              ],
            ),
          ),
        ],
      ),
    );
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
