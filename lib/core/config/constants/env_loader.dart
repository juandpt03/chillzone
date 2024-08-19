import 'package:flutter/services.dart' show rootBundle;

class EnvLoader {
  static final EnvLoader _instance = EnvLoader._internal();
  late Map<String, String> _envVariables;

  EnvLoader._internal();

  factory EnvLoader() => _instance;

  Future<void> loadEnv(String path) async {
    final envString = await rootBundle.loadString(path);
    _envVariables = _parseEnv(envString);
  }

  Map<String, String> _parseEnv(String envString) {
    final lines = envString.split('\n');
    final map = <String, String>{};

    for (var line in lines) {
      if (line.isNotEmpty && !line.startsWith('#')) {
        final keyValue = line.split('=');
        if (keyValue.length == 2) {
          map[keyValue[0].trim()] = keyValue[1].trim();
        }
      }
    }
    return map;
  }

  String? get(String key) {
    return _envVariables[key];
  }
}
