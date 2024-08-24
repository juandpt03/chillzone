import 'package:chillzone/core/utils/failures.dart';
import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:chillzone/features/home/presentation/providers/providers.dart';
import 'package:chillzone/features/home/repositories/pixabay_repository.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PixabayImagesNotifier extends ChangeNotifier {
  final PixabayRepository repository;
  AudioGenre genre;

  PixabayImagesNotifier({
    required this.repository,
    this.genre = AudioGenre.sleep,
  }) {
    // getImages(genre);
    generateRandomImages();
  }

  PixabayImagesState _state = const PixabayImagesState.loading();
  PixabayImagesState get state => _state;

  set state(PixabayImagesState state) {
    _state = state;
    notifyListeners();
  }

  // Future<void> getImages(AudioGenre genre) async {
  //   _state = const PixabayImagesState.loading();
  //   notifyListeners();

  //   final result = await repository.getImages(genre: genre);

  //   result.when(
  //     right: (images) {
  //       state = PixabayImagesState.success(images: images);
  //     },
  //     left: (error) {
  //       state = PixabayImagesState.error(error: error);
  //     },
  //   );
  // }

  void updateGenre(AudioGenre genre) {
    this.genre = genre;

    generateRandomImages();
  }

  void imageUrl(int index) {
    state = state.map(
      loading: (_) => const PixabayImagesState.loading(),
      success: (state) => state.copyWith(imageUrl: state.images[index]),
      error: (state) => PixabayImagesState.error(error: state.error),
    );
  }

  void generateRandomImages() {
    try {
      const String baseUrl =
          "https://gxqlzeksbkmbheddeheh.supabase.co/storage/v1/object/public/music/images/";
      Random random = Random();
      Set<int> uniqueNumbers = {};

      while (uniqueNumbers.length < 20) {
        uniqueNumbers.add(random.nextInt(100) + 1);
      }

      final List<String> images = uniqueNumbers.map((number) {
        return "$baseUrl$number.jpg";
      }).toList();

      state = PixabayImagesState.success(images: images);
      notifyListeners();
    } catch (e) {
      state = const PixabayImagesState.error(error: HttpRequestFailure.local);
      notifyListeners();
    }
  }
}
