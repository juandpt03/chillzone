import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:chillzone/features/home/models/models.dart';
import 'package:chillzone/features/home/presentation/providers/message/message_state.dart';
import 'package:chillzone/features/home/repositories/open_ai_repository.dart';
import 'package:flutter/foundation.dart';

class MessageProvider extends ChangeNotifier {
  final OpenAiRepository messageRepository;

  final AudioGenre genre;

  MessageState _state = const MessageState.loading();

  MessageState get state => _state;

  set state(MessageState state) {
    _state = state;
    if (hasListeners) {
      notifyListeners();
    }
  }

  MessageProvider({
    required this.messageRepository,
    this.genre = AudioGenre.sleep,
  }) {
    // getMessages();
  }

  Future<void> getMessages() async {
    final chatRequest = ChatRequest.system(genre: genre);

    final result =
        await messageRepository.getMessages(chatRequest: chatRequest);

    state = result.when(
      left: (error) => MessageState.error(error: error),
      right: (message) => MessageState.success(message: message),
    );
  }
}
