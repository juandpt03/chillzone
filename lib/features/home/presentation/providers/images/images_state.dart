import 'package:chillzone/core/core.dart';
import 'package:chillzone/features/home/models/models.dart';

sealed class ImagesState {
  const ImagesState();

  const factory ImagesState.loading() = Loading;
  const factory ImagesState.success({required List<DalleImage> images}) =
      Success;
  const factory ImagesState.error({required HttpRequestFailure error}) = Error;

  T map<T>({
    required T Function(Loading) loading,
    required T Function(Success) success,
    required T Function(Error) error,
  }) {
    if (this is Loading) {
      return loading(this as Loading);
    } else if (this is Success) {
      return success(this as Success);
    } else if (this is Error) {
      return error(this as Error);
    } else {
      throw Exception('Unknown state: $this');
    }
  }
}

class Loading extends ImagesState {
  const Loading();
}

class Success extends ImagesState {
  final List<DalleImage> images;

  const Success({required this.images});
}

class Error extends ImagesState {
  final HttpRequestFailure error;

  const Error({required this.error});
}
