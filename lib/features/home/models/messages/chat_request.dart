import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:chillzone/features/home/models/messages/message.dart';

class ChatRequest {
  final String model;
  final List<Message> messages;
  final double temperature;
  final int n;

  ChatRequest({
    this.model = 'gpt-3.5-turbo-0125',
    this.messages = const [],
    this.temperature = 0.7,
    this.n = 1,
  });

  factory ChatRequest.fromJson(Map<String, dynamic> json) => ChatRequest(
        model: json["model"],
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
        temperature: json["temperature"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "temperature": temperature,
        "n": n,
      };

  factory ChatRequest.system({required AudioGenre genre}) => ChatRequest(
        model: 'gpt-3.5-turbo-0125',
        messages: [
          Message(role: Role.system, message: '''
      You're a master of punchy, memorable quotes that pack a powerful punch in just a few words. Your task is to create a short, sharp, and motivating phrase that sparks enthusiasm for the following activity: ${genre.name}. Think of iconic one-liners—something Yoda might say about meditation, or Muhammad Ali about exercise. The key is to be brief, impactful, and maybe even a little playful. Make every word count!
      ''')
        ],
        temperature: 0.7,
        n: 1,
      );

  ChatRequest copyWith(
      {String? model, List<Message>? messages, double? temperature, int? n}) {
    return ChatRequest(
      model: model ?? this.model,
      messages: messages ?? this.messages,
      temperature: temperature ?? this.temperature,
      n: n ?? this.n,
    );
  }
}
