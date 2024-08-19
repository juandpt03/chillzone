import 'package:chillzone/core/config/theme/app_theme.dart';
import 'package:chillzone/features/home/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/services/service_locator/di.dart';
import 'features/home/presentation/providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DI.setup();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
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
      theme: AppTheme().getAppTheme(),
      home: const HomeScreen(),
    );
  }
}
