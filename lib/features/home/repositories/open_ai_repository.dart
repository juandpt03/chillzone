import 'package:chillzone/core/core.dart';
import 'package:chillzone/features/home/models/models.dart';
import 'package:dio/dio.dart';

class OpenAiRepository {
  final Dio dio;

  OpenAiRepository({required this.dio});
  Future<Either<HttpRequestFailure, Message>> getMessages(
      {required ChatRequest chatRequest}) async {
    try {
      final response = await dio.post(
        chatCompletionsPath,
        data: chatRequest.toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer ${Environment().apikey}'},
        ),
      );

      if (response.statusCode == 200) {
        final chatResponse = ChatResponse.fromJson(response.data);
        return Either.right(chatResponse.choices.first.message);
      }

      throw (HttpRequestFailure.fromCode(response.statusCode));
    } on Exception catch (e) {
      return Either.left(HttpRequestFailure.fromException(e));
    }
  }

  Future<Either<HttpRequestFailure, List<DalleImage>>> getImages(
      {required ImageRequest imagesRequest}) async {
    try {
      final response = await dio.post(
        imagesGeneratePath,
        data: imagesRequest.toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer ${Environment().apikey}'},
        ),
      );

      if (response.statusCode == 200) {
        final imageResponse = ImageResponse.fromJson(response.data);
        return Either.right(imageResponse.images);
      }

      throw (HttpRequestFailure.fromCode(response.statusCode));
    } on Exception catch (e) {
      return Either.left(HttpRequestFailure.fromException(e));
    }
  }
}
