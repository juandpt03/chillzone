import 'package:chillzone/core/config/router/router.dart';
import 'package:chillzone/core/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/home/presentation/providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DI.setup();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
        ChangeNotifierProvider(
          create: (context) => AudioPlayerNotifier(
            audioPlayer: ServiceLocator().get(),
            audioProvider: context.read<AudioProvider>(),
          ),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
          PointerDeviceKind.trackpad
        },
        physics: const BouncingScrollPhysics(),
      ),
      theme: AppTheme().getAppTheme(),
      initialRoute: '/',
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}
