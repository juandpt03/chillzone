import 'package:chillzone/core/config/constants/env_loader.dart';
import 'package:chillzone/core/services/service_locator/service_locator.dart';

class Environment {
  static final Environment _instance = Environment._internal();
  static final EnvLoader _envLoader = ServiceLocator().get<EnvLoader>();

  Environment._internal();

  factory Environment() => _instance;

  final apikey = _envLoader.get('API_KEY');
}
