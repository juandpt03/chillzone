import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:chillzone/features/home/models/models.dart';
import 'package:chillzone/features/home/presentation/providers/images/images_state.dart';
import 'package:chillzone/features/home/repositories/open_ai_repository.dart';
import 'package:flutter/foundation.dart';

class ImagesProvider extends ChangeNotifier {
  final OpenAiRepository imagesRepository;
  final AudioGenre genre;
  ImagesState _state = const ImagesState.loading();

  ImagesProvider(
      {required this.imagesRepository, this.genre = AudioGenre.sleep}) {
    getImages();
  }

  ImagesState get state => _state;

  set state(ImagesState state) {
    _state = state;
    if (hasListeners) {
      notifyListeners();
    }
  }

  Future<void> getImages() async {
    final imagesRequest = ImageRequest(
        prompt:
            '''Generate a professional, high-quality image that captures the essence of ${genre.name}.
            The image should visually convey the mood and energy specific to this activity, creating a seamless match between the visual representation and the intended experience.''');

    final result =
        await imagesRepository.getImages(imagesRequest: imagesRequest);

    state = result.when(
      left: (error) => ImagesState.error(error: error),
      right: (images) => ImagesState.success(images: images),
    );
  }
}
