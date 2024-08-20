import 'package:chillzone/core/core.dart';
import 'package:chillzone/features/home/repositories/open_ai_repository.dart';
import 'package:chillzone/features/shared/presentation/widgets/transitions/transitions_manager.dart';
import 'package:dio/dio.dart';

class DI {
  static ServiceLocator get serviceLocator => ServiceLocator();

  DI._internal();

  static Future<void> setup() async {
    await EnvLoader().loadEnv('.env');
    serviceLocator.register(EnvLoader());
    serviceLocator.register(Environment());
    serviceLocator.register(Dio(
      BaseOptions(baseUrl: baseApiUrl, contentType: 'application/json'),
    ));
    serviceLocator.register(OpenAiRepository(dio: serviceLocator.get<Dio>()));
    serviceLocator.register(TransitionManager());
  }
}
