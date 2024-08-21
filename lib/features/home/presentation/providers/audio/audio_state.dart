import 'package:chillzone/core/core.dart';
import 'package:chillzone/features/home/models/audio/audio_track.dart';

sealed class AudioState {
  const AudioState();

  const factory AudioState.loading() = Loading;
  const factory AudioState.success({
    List<AudioTrack> tracks,
    required AudioTrack currentTrack,
  }) = Success;
  const factory AudioState.error({required HttpRequestFailure error}) = Error;

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

class Loading extends AudioState {
  const Loading();
}

class Success extends AudioState {
  final List<AudioTrack> tracks;
  final AudioTrack currentTrack;

  const Success({
    this.tracks = const [],
    required this.currentTrack,
  });

  Success copyWith({
    List<AudioTrack>? tracks,
    AudioTrack? currentTrack,
  }) {
    return Success(
      tracks: tracks ?? this.tracks,
      currentTrack: currentTrack ?? this.currentTrack,
    );
  }
}

class Error extends AudioState {
  final HttpRequestFailure error;

  const Error({required this.error});
}

extension AudioStateX on AudioState {
  Success get success => map(
        loading: (state) => Success(currentTrack: AudioTrack.empty()),
        success: (state) => state,
        error: (state) => Success(currentTrack: AudioTrack.empty()),
      );
}
