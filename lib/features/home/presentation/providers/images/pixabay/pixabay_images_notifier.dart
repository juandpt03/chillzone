import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:chillzone/features/home/presentation/providers/providers.dart';
import 'package:chillzone/features/home/repositories/pixabay_repository.dart';
import 'package:flutter/material.dart';

class PixabayImagesNotifier extends ChangeNotifier {
  final PixabayRepository repository;
  AudioGenre genre;

  PixabayImagesNotifier({
    required this.repository,
    this.genre = AudioGenre.sleep,
  }) {
    getImages(genre);
  }

  PixabayImagesState _state = const PixabayImagesState.loading();
  PixabayImagesState get state => _state;

  set state(PixabayImagesState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getImages(AudioGenre genre) async {
    _state = const PixabayImagesState.loading();
    notifyListeners();

    final result = await repository.getImages(genre: genre);

    result.when(
      right: (images) {
        state = PixabayImagesState.success(images: images);
      },
      left: (error) {
        state = PixabayImagesState.error(error: error);
      },
    );
  }

  void updateGenre(AudioGenre genre) {
    this.genre = genre;
    getImages(genre);
  }

  void imageUrl(int index) {
    state = state.map(
      loading: (_) => const PixabayImagesState.loading(),
      success: (state) => state.copyWith(imageUrl: state.images[index]),
      error: (state) => PixabayImagesState.error(error: state.error),
    );
  }
}
