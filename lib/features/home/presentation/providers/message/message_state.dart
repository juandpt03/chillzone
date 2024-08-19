import 'package:chillzone/core/core.dart';
import 'package:chillzone/features/home/models/messages/message.dart';

sealed class MessageState {
  const MessageState();

  const factory MessageState.loading() = Loading;
  const factory MessageState.success({required Message message}) = Success;
  const factory MessageState.error({required HttpRequestFailure error}) = Error;

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

class Loading extends MessageState {
  const Loading();
}

class Success extends MessageState {
  final Message message;

  const Success({required this.message});
}

class Error extends MessageState {
  final HttpRequestFailure error;

  const Error({required this.error});
}
