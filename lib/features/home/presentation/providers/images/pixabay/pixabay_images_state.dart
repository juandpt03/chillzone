import 'package:chillzone/core/core.dart';

sealed class PixabayImagesState {
  const PixabayImagesState();

  const factory PixabayImagesState.loading() = PixabayLoading;
  const factory PixabayImagesState.success(
      {required List<String> images, String imageUrl}) = PixabaySuccess;
  const factory PixabayImagesState.error({required HttpRequestFailure error}) =
      PixabayError;

  T map<T>({
    required T Function(PixabayLoading) loading,
    required T Function(PixabaySuccess) success,
    required T Function(PixabayError) error,
  }) {
    if (this is PixabayLoading) {
      return loading(this as PixabayLoading);
    } else if (this is PixabaySuccess) {
      return success(this as PixabaySuccess);
    } else if (this is PixabayError) {
      return error(this as PixabayError);
    } else {
      throw Exception('Unknown state: $this');
    }
  }
}

class PixabayLoading extends PixabayImagesState {
  const PixabayLoading();
}

class PixabaySuccess extends PixabayImagesState {
  final List<String> images;
  final String imageUrl;

  const PixabaySuccess({required this.images, this.imageUrl = ''});

  PixabaySuccess copyWith({
    List<String>? images,
    String? imageUrl,
  }) =>
      PixabaySuccess(
        images: images ?? this.images,
        imageUrl: imageUrl ?? this.imageUrl,
      );
}

class PixabayError extends PixabayImagesState {
  final HttpRequestFailure error;

  const PixabayError({required this.error});
}
