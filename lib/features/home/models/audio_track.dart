class AudioTrack {
  final String title;
  final String composer;
  final AudioGenre genre;
  final String filePath;

  AudioTrack({
    required this.title,
    required this.composer,
    required this.genre,
    required this.filePath,
  });

  factory AudioTrack.fromJson(Map<String, dynamic> json) {
    return AudioTrack(
      title: json['title'],
      composer: json['composer'],
      genre: genreFromString(json['genre']),
      filePath: json['filePath'],
    );
  }
}

enum AudioGenre {
  sleep,
  work,
  read,
  exercise,
  meditate,
}

extension GenreExtension on AudioGenre {
  String get name {
    switch (this) {
      case AudioGenre.sleep:
        return 'Sleep';
      case AudioGenre.work:
        return 'Work';
      case AudioGenre.read:
        return 'Read';
      case AudioGenre.exercise:
        return 'Exercise';
      case AudioGenre.meditate:
        return 'Meditate';
    }
  }
}

AudioGenre genreFromString(String genre) {
  return AudioGenre.values.firstWhere(
      (e) => e.name.toLowerCase() == genre.toLowerCase(),
      orElse: () => AudioGenre.sleep);
}
