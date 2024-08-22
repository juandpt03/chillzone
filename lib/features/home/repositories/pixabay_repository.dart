import 'package:chillzone/core/core.dart';
import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:dio/dio.dart';

class PixabayRepository {
  final Dio dio;

  PixabayRepository({required this.dio});

  Future<Either<HttpRequestFailure, List<String>>> getImages(
      {required AudioGenre genre}) async {
    try {
      final String query = QueryGenerator().generateQuery(genre);
      final response = await dio.get(
        'https://pixabay.com/api/',
        queryParameters: {
          'key': Environment().pixabayApiKey,
          'q': query,
          'image_type': 'all',
          'per_page': 20,
          'min_width': 1920,
          'min_height': 1080,
          'safesearch': 'true',
          'order': 'popular',
          'orientation': 'horizontal',
        },
      );
      if (response.statusCode == 200) {
        final List<String> images = List<String>.from(
            response.data['hits'].map((image) => image['largeImageURL']));
        return Either.right(images);
      }

      throw HttpRequestFailure.fromCode(response.statusCode);
    } on Exception catch (e) {
      return Either.left(HttpRequestFailure.fromException(e));
    }
  }
}
